class AddFreezeToCommande < ActiveRecord::Migration
  def change
    add_column :commandes, :freeze, :boolean

  end
end
