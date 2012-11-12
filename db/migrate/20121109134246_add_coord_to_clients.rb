class AddCoordToClients < ActiveRecord::Migration
  def change
    add_column :clients, :coord_x, :float

    add_column :clients, :coord_y, :float

  end
end
