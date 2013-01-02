class AddPaysIdToClients < ActiveRecord::Migration
  def change
    add_column :clients, :pays_id, :integer

  end
end
