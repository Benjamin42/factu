class AddIdColumnsFactuCsvToProduit < ActiveRecord::Migration
  def change
    add_column :produits, :id_columns_factu_csv, :integer

  end
end
