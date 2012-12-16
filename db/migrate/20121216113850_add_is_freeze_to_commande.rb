class AddIsFreezeToCommande < ActiveRecord::Migration
  def change
    add_column :commandes, :is_freeze, :boolean

  end
end
