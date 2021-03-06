# -*- coding: utf-8 -*-
class CommandeProduit < ActiveRecord::Base
  belongs_to :commande
  belongs_to :bdl
  belongs_to :tarif
  belongs_to :produit
  
  scope :bouteille, joins(:produit).where('produits.label' => 'Bouteille')
  
  validate :check_qty_bdl
  validates_presence_of :qty
  
  def check_qty_bdl
    if !commande.nil? && !commande.bdl.nil?
      result = CommandeProduit.getTotalRestBdl(commande.bdl)
    
      result.each do |res|
        if res.label == produit.label
          if qty != nil && (qty < 0 || res == nil || qty > res.qty)
            self.errors.add(:qty, "Quantitée insuffisante")
          end
        end
        
      end
    end
  end    
  
  def self.create_with_produit(commande, bdl, produit)
    commandeProduit = CommandeProduit.new()
    commandeProduit.attributes = {
      :commande => commande,
      :bdl => bdl,
      :produit => produit,
      :qty => 0,
      :qty_cadeau => 0
    }
    return commandeProduit
  end
  
  def self.delete_line(produit)
    @commande_produits = find(:all, :conditions => ['produit_id = ?', produit])
    @commande_produits.each do |cp|
      cp.destroy
    end
  end
    
  def self.build_from_csv(row, commande, produit)
    commandeProduit = CommandeProduit.new
    commandeProduit.attributes = {
      :commande_id => commande,
      :produit_id => produit.id,
      :tarif => Tarif.findTarif(produit, Date.strptime(row[4], '%d/%m/%y').strftime('%Y')),
      :qty => row[produit.id_columns_factu_csv],
      :qty_cadeau => row[produit.id_columns_factu_csv + 1]
    }
    return commandeProduit
  end
  
  def calcMontantTTC
    if self.qty != nil
      return (self.qty * self.tarif.prix_unitaire_ht).round(2)
    else
      return ""
    end
  end
  
  def self.listForFinDeMois
    find_by_sql("SELECT num_bdl, num_factu, label, qty, qty_cadeau, dater FROM (
      SELECT null as num_bdl, num_factu as num_factu, P.label, qty, qty_cadeau, date_factu as dater FROM COMMANDE_PRODUITS CP
        JOIN COMMANDES C ON C.id = CP.commande_id
        JOIN PRODUITS P ON P.id = CP.produit_id
        WHERE C.bdl_id is null
          AND C.date_factu is not null
      UNION ALL
      SELECT num_bdl as num_bdl, null as num_factu, P.label, qty, qty_cadeau, date_bdl as dater FROM COMMANDE_PRODUITS CP
        JOIN BDLS B ON B.id = CP.bdl_id
        JOIN PRODUITS P ON P.id = CP.produit_id
        WHERE B.date_bdl is not null
      ) ORDER BY dater")
  end
  
  def self.getTotalRestBdl(bdl)
    find_by_sql("select p.label, cp.qty, cp.qty - (select sum(qty) from commande_produits cp2 join commandes c on cp2.commande_id = c.id where produit_id = p.id and c.bdl_id = #{ bdl.id } ) as rest from commande_produits cp join produits p on cp.produit_id = p.id where cp.bdl_id = #{ bdl.id }")
  end

end
