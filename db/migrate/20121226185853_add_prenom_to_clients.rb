class AddPrenomToClients < ActiveRecord::Migration
  def change
    add_column :clients, :prenom, :string

  end
end
