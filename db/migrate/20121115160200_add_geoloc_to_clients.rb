class AddGeolocToClients < ActiveRecord::Migration
  def change
    add_column :clients, :long_adresse, :string

    add_column :clients, :longitude, :float

    add_column :clients, :latitude, :float

  end
end
