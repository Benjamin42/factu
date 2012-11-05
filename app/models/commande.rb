class Commande < ActiveRecord::Base
  has_many :commande_produit
  belongs_to :client
  
  def commande_produit_attributes=(commande_produit)
  commande_produit.each do |attributes|
    tasks.build(attributes)
  end
end
end
