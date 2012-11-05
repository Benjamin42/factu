class CommandeProduit < ActiveRecord::Base
  belongs_to :commande
  belongs_to :tarif
  belongs_to :produit
  
  def self.create_with_produit(commande, produit)
    commandeProduit = CommandeProduit.new()
    commandeProduit.attributes = {
      :commande => commande,
      :produit => produit,
      :qty => 0,
      :cadeau => false
    }
    return commandeProduit
  end
end
