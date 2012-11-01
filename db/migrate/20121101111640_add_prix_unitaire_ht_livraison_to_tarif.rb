class AddPrixUnitaireHtLivraisonToTarif < ActiveRecord::Migration
  def change
    add_column :tarifs, :prix_unitaire_ht_livraison, :float

  end
end
