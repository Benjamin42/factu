class CreateMailings < ActiveRecord::Migration
  def change
    create_table :mailings do |t|
      t.text :t_texte
      t.integer :statut_id

      t.timestamps
    end
  end
end
