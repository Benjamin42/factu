class AddProduitIdToTarif < ActiveRecord::Migration
  def change
    add_column :tarifs, :produit_id, :integer

  end
end
