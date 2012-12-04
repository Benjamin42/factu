class AddNameValueToParameters < ActiveRecord::Migration
  def change
    add_column :parameters, :p_name, :string

    add_column :parameters, :p_value, :string

  end
end
