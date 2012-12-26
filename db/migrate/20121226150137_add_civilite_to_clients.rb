class AddCiviliteToClients < ActiveRecord::Migration
  def change
    add_column :clients, :civilite_id, :integer

  end
end
