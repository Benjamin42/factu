class AddBoolDatesToCommande < ActiveRecord::Migration
  def change
    add_column :commandes, :is_livraison, :boolean

    add_column :commandes, :is_paiement, :boolean

  end
end
