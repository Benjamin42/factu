# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130103114107) do

  create_table "bdls", :force => true do |t|
    t.integer  "client_id"
    t.string   "label"
    t.integer  "num_bdl"
    t.date     "date_bdl"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.float    "majoration"
  end

  create_table "cleaning_pays", :force => true do |t|
    t.string   "nom"
    t.string   "code_pays"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cleaning_villes", :force => true do |t|
    t.string   "nom"
    t.string   "nom_majuscule"
    t.string   "code_postal"
    t.string   "code_insee"
    t.string   "code_region"
    t.float    "latitude"
    t.float    "longitude"
    t.float    "eloignement"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "clients", :force => true do |t|
    t.integer  "num_client"
    t.string   "num_tva"
    t.string   "nom"
    t.string   "nom_info"
    t.string   "bat"
    t.string   "num_voie"
    t.string   "bp"
    t.string   "codepostal"
    t.string   "ville"
    t.string   "tel"
    t.string   "portable"
    t.string   "fax"
    t.string   "email"
    t.string   "commentaire"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "long_adresse"
    t.float    "longitude"
    t.float    "latitude"
    t.boolean  "cleaning"
    t.integer  "civilite_id"
    t.string   "prenom"
    t.integer  "pays_id"
  end

  create_table "commande_produits", :force => true do |t|
    t.integer  "commande_id"
    t.integer  "tarif_id"
    t.integer  "qty"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "produit_id"
    t.integer  "qty_cadeau"
    t.integer  "bdl_id"
  end

  create_table "commande_services", :force => true do |t|
    t.integer  "commande_id"
    t.integer  "bdl_id"
    t.integer  "service_id"
    t.float    "montant"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "commandes", :force => true do |t|
    t.integer  "num_factu"
    t.integer  "bdl_id"
    t.integer  "client_id"
    t.date     "date_factu"
    t.integer  "nb_etiquette"
    t.string   "statut"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.date     "date_livraison"
    t.date     "date_paiement"
    t.boolean  "is_livraison"
    t.boolean  "is_paiement"
    t.boolean  "a_livrer"
    t.boolean  "is_freeze"
  end

  create_table "mailings", :force => true do |t|
    t.text     "t_texte"
    t.integer  "statut_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "parameters", :force => true do |t|
    t.string   "p_name"
    t.string   "p_value"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "grp"
    t.string   "description"
  end

  create_table "produits", :force => true do |t|
    t.string   "label"
    t.string   "commentaire"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "id_columns_factu_csv"
  end

  create_table "services", :force => true do |t|
    t.string   "label"
    t.string   "commentaire"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tarifs", :force => true do |t|
    t.float    "prix_unitaire_ht"
    t.integer  "annee"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "produit_id"
    t.float    "prix_unitaire_ht_livraison"
  end

  create_table "types", :force => true do |t|
    t.string   "label"
    t.string   "code"
    t.string   "grp"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
