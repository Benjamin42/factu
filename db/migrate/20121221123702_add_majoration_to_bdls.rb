class AddMajorationToBdls < ActiveRecord::Migration
  def change
    add_column :bdls, :majoration, :float

  end
end
