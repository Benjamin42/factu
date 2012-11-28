class CreateBdls < ActiveRecord::Migration
  def change
    create_table :bdls do |t|
      t.integer :client_id
      t.string :label
      t.integer :num_bdl
      t.date :date_bdl

      t.timestamps
    end
  end
end
