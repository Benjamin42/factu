class Commande < ActiveRecord::Base
  has_many :commande_produit
  belongs_to :client
  
  validates_presence_of :client
  
  def self.next_num_factu
    resReq = find_by_sql("select max(num_factu) + 1 as num_factu from commandes").first.num_factu
    if resReq != nil && resReq != "" then
      return resReq
    else
      return 0
    end
  end
  
  def commande_produit_attributes=(commande_produit_attributes)
    commande_produit_attributes.each do |attributes|
      commandeProduit = commande_produit.build(attributes)
      commandeProduit.attributes = {
        :produit => Produit.find(attributes[:produit_id])
      }
    end
  end
  
  def qtyTotal
    count = 0
    self.commande_produit.all.each do |commandeProduit|
      count += commandeProduit.qty
    end
    
    return count
  end
end
