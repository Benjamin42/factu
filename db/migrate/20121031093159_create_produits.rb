class CreateProduits < ActiveRecord::Migration
  def change
    create_table :produits do |t|
      t.string :label
      t.string :commentaire

      t.timestamps
    end
  end
end
