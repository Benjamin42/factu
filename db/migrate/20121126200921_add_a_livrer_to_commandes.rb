class AddALivrerToCommandes < ActiveRecord::Migration
  def change
    add_column :commandes, :a_livrer, :boolean

  end
end
