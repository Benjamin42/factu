class AddQtyCadeauToCommandeProduit < ActiveRecord::Migration
  def change
    add_column :commande_produits, :qty_cadeau, :integer

  end
end
