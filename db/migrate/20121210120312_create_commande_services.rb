class CreateCommandeServices < ActiveRecord::Migration
  def change
    create_table :commande_services do |t|
      t.integer :commande_id
      t.integer :bdl_id
      t.integer :service_id
      t.float :montant

      t.timestamps
    end
  end
end
