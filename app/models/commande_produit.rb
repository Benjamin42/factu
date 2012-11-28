class CommandeProduit < ActiveRecord::Base
  belongs_to :commande
  belongs_to :bdl
  belongs_to :tarif
  belongs_to :produit
  
  scope :bouteille, joins(:produit).where('produits.label' => 'Bouteille')
  
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

end
