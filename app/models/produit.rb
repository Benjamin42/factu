class Produit < ActiveRecord::Base
  has_many :tarif
  
  validates_presence_of :label
end
