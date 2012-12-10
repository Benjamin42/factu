class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :label
      t.string :commentaire

      t.timestamps
    end
  end
end
