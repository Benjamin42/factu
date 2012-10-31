class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.integer :num_client
      t.string :num_tva
      t.string :nom
      t.string :nom_info
      t.string :bat
      t.string :num_voie
      t.string :bp
      t.string :codepostal
      t.string :ville
      t.string :pays
      t.string :tel
      t.string :portable
      t.string :fax
      t.string :email
      t.string :commentaire

      t.timestamps
    end
  end
end
