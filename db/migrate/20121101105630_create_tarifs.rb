class CreateTarifs < ActiveRecord::Migration
  def change
    create_table :tarifs do |t|
      t.float :prix_unitaire_ht
      t.integer :annee

      t.timestamps
    end
  end
end
