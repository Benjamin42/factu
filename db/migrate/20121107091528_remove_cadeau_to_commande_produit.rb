class RemoveCadeauToCommandeProduit < ActiveRecord::Migration
  def change
    remove_column :commande_produits, :cadeau
  end
end
