class CreateCleaningPays < ActiveRecord::Migration
  def change
    create_table :cleaning_pays do |t|
      t.string :nom
      t.string :code_pays

      t.timestamps
    end
  end
end
