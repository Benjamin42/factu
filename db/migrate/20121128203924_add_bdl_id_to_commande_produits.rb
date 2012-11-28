class AddBdlIdToCommandeProduits < ActiveRecord::Migration
  def change
    add_column :commande_produits, :bdl_id, :integer

  end
end
