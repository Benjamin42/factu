class Produit < ActiveRecord::Base
  has_many :tarif
  has_many :commande_produit
  
  
  validates_presence_of :label
  
  def countRef
    CommandeProduit.find(:all, :conditions => ["produit_id = ? and qty > 0", id]).size
  end
end
