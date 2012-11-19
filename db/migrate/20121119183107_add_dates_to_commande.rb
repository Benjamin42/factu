class AddDatesToCommande < ActiveRecord::Migration
  def change
    add_column :commandes, :date_livraison, :date

    add_column :commandes, :date_paiement, :date

  end
end
