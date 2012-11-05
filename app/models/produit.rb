class Produit < ActiveRecord::Base
  has_many :tarif
  has_many :commande_produit
  
  validates_presence_of :label
end
