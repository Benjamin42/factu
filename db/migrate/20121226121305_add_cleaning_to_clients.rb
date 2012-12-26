class AddCleaningToClients < ActiveRecord::Migration
  def change
    add_column :clients, :cleaning, :boolean

  end
end
