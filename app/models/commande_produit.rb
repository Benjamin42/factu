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
      :qty_cadeau => 0
    }
    return commandeProduit
  end
  
  def self.build_from_csv(row, commande, produit)
    # find existing customer from email or create new
    commandeProduit = CommandeProduit.new
    commandeProduit.attributes = {
      :commande_id => commande,
      :produit_id => produit.id,
      #:tarif_id => row[0], # TODO
      :qty => row[produit.id_columns_factu_csv],
      :qty_cadeau => row[produit.id_columns_factu_csv + 1]
    }
    return commandeProduit
  end
  
  def calcTarif(commande)
    #if commande.date_factu.strftime('%y')
  end
end
