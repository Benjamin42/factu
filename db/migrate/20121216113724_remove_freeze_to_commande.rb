class RemoveFreezeToCommande < ActiveRecord::Migration
  def up
    remove_column :commandes, :freeze
      end

  def down
    add_column :commandes, :freeze, :boolean
  end
end
