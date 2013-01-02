class RemovePaysToClients < ActiveRecord::Migration
  def up
    remove_column :clients, :pays
      end

  def down
    add_column :clients, :pays, :string
  end
end
