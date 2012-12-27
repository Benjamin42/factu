class CreateCleaningVilles < ActiveRecord::Migration
  def change
    create_table :cleaning_villes do |t|
      t.string :nom
      t.string :nom_majuscule
      t.string :code_postal
      t.string :code_insee
      t.string :code_region
      t.float :latitude
      t.float :longitude
      t.float :eloignement

      t.timestamps
    end
  end
end
