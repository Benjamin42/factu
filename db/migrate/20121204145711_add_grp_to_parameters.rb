class AddGrpToParameters < ActiveRecord::Migration
  def change
    add_column :parameters, :grp, :string

  end
end
