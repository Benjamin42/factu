class Tarif < ActiveRecord::Base
  belongs_to :produit
  has_many :commande_produit
  
  def self.find_by_produit(produit)
    Tarif.find(:all, :conditions => ['produit_id = ?', produit])
    # find_by_sql("select * from tarifs where produit_id = #{idProduit}")
  end

  def self.hash_year
    my_hash = Hash.new

    tabYear = find_by_sql("select distinct annee from tarifs order by annee")
    tabYear.each do  |year|
      hash_year = Hash.new
      tabTarif = Tarif.find(:all, :conditions => ['annee = ?', year.annee])

      tabTarif.each do |tarif|
        hash_year[tarif.produit_id] = tarif

      end
      my_hash[year.annee] = hash_year
    end
    return my_hash
  end

  def self.annee_suivante
    return find_by_sql("select max(annee) + 1 as annee from tarifs").first.annee
  end
  
  def self.list_annee
    return find_by_sql("select distinct annee as annee from tarifs")
  end  

  def self.create_tarif(produit, annee)
    tarif = Tarif.new()
    tarif.attributes = {

      :produit => produit,
      :annee => annee,
      :prix_unitaire_ht => 0,
      :prix_unitaire_ht_livraison => 0
    }
    return tarif
  end
  
  def self.delete_tarif(produit)
    @tarifs = self.find_by_produit(produit)
    @tarifs.each do |tarif|
      tarif.destroy
    end
  end

  def self.findTarif(produit, annee)
    return Tarif.find(:first, :conditions => ["annee = ? and produit_id = ?", annee, produit.id])
  end
end
