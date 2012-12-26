class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :label
      t.string :code
      t.string :grp

      t.timestamps
    end
  end
end
