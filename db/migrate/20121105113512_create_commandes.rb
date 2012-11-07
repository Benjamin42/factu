class CreateCommandes < ActiveRecord::Migration
  def change
    create_table :commandes do |t|
      t.integer :num_factu
      t.integer :bdl_id
      t.integer :client_id
      t.date :date_factu
      t.integer :nb_etiquette
      t.string :statut

      t.timestamps
    end
  end
end
