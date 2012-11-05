class AddProduitIdToCommandeProduit < ActiveRecord::Migration
  def change
    add_column :commande_produits, :produit_id, :integer

  end
end
