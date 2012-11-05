class CreateCommandeProduits < ActiveRecord::Migration
  def change
    create_table :commande_produits do |t|
      t.integer :commande_id
      t.integer :tarif_id
      t.integer :qty
      t.boolean :cadeau

      t.timestamps
    end
  end
end
