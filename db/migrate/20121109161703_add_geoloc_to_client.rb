class AddGeolocToClient < ActiveRecord::Migration
  def change
    add_column :clients, :lat, :float

    add_column :clients, :lng, :float

  end
end
