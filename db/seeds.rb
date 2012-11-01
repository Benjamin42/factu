# -*- coding: utf-8 -*-

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Client.delete_all()
Produit.delete_all()
Tarif.delete_all()

bouteille = Produit.create([label: 'Bouteille', commentaire: ''])
demi = Produit.create([label: 'Demi Bouteille', commentaire: ''])
magnum = Produit.create([label: 'Magnum', commentaire: ''])
jero = Produit.create([label: 'Jéroboam', commentaire: ''])
mathu = Produit.create([label: 'Mathusalem', commentaire: ''])
privilege = Produit.create([label: 'Privilège', commentaire: 'La bouteille'])
rose = Produit.create([label: 'Rosé', commentaire: 'La bouteille'])
prestige = Produit.create([label: 'Prestige', commentaire: 'La bouteille'])

Tarif.create([annee: 2010, prix_unitaire_ht: 6.9, prix_unitaire_ht_livraison: 6.9, produit: demi.first])
Tarif.create([annee: 2010, prix_unitaire_ht: 11.9, prix_unitaire_ht_livraison: 12, produit: bouteille.first])
Tarif.create([annee: 2010, prix_unitaire_ht: 25.9, prix_unitaire_ht_livraison: 25.9, produit: magnum.first])
Tarif.create([annee: 2010, prix_unitaire_ht: 92, prix_unitaire_ht_livraison: 92, produit: jero.first])
Tarif.create([annee: 2010, prix_unitaire_ht: 188, prix_unitaire_ht_livraison: 188, produit: mathu.first])
Tarif.create([annee: 2010, prix_unitaire_ht: 13, prix_unitaire_ht_livraison: 13.1, produit: privilege.first])
Tarif.create([annee: 2010, prix_unitaire_ht: 14.2, prix_unitaire_ht_livraison: 14.2, produit: rose.first])
Tarif.create([annee: 2010, prix_unitaire_ht: 16.1, prix_unitaire_ht_livraison: 16.1, produit: prestige.first])

Tarif.create([annee: 2011, prix_unitaire_ht: 6.9, prix_unitaire_ht_livraison: 7, produit: demi.first])
Tarif.create([annee: 2011, prix_unitaire_ht: 11.9, prix_unitaire_ht_livraison: 12, produit: bouteille.first])
Tarif.create([annee: 2011, prix_unitaire_ht: 25.9, prix_unitaire_ht_livraison: 26.4, produit: magnum.first])
Tarif.create([annee: 2011, prix_unitaire_ht: 92, prix_unitaire_ht_livraison: 92, produit: jero.first])
Tarif.create([annee: 2011, prix_unitaire_ht: 188, prix_unitaire_ht_livraison: 188, produit: mathu.first])
Tarif.create([annee: 2011, prix_unitaire_ht: 13, prix_unitaire_ht_livraison: 13.1, produit: privilege.first])
Tarif.create([annee: 2011, prix_unitaire_ht: 14.2, prix_unitaire_ht_livraison: 14.2, produit: rose.first])
Tarif.create([annee: 2011, prix_unitaire_ht: 16.1, prix_unitaire_ht_livraison: 16.1, produit: prestige.first])

Tarif.create([annee: 2012, prix_unitaire_ht: 7.9, prix_unitaire_ht_livraison: 8, produit: demi.first])
Tarif.create([annee: 2012, prix_unitaire_ht: 13.2, prix_unitaire_ht_livraison: 13.5, produit: bouteille.first])
Tarif.create([annee: 2012, prix_unitaire_ht: 26.9, prix_unitaire_ht_livraison: 27.5, produit: magnum.first])
Tarif.create([annee: 2012, prix_unitaire_ht: 92, prix_unitaire_ht_livraison: 92, produit: jero.first])
Tarif.create([annee: 2012, prix_unitaire_ht: 188, prix_unitaire_ht_livraison: 188, produit: mathu.first])
Tarif.create([annee: 2012, prix_unitaire_ht: 14, prix_unitaire_ht_livraison: 14.1, produit: privilege.first])
Tarif.create([annee: 2012, prix_unitaire_ht: 14.2, prix_unitaire_ht_livraison: 14.2, produit: rose.first])
Tarif.create([annee: 2012, prix_unitaire_ht: 16.1, prix_unitaire_ht_livraison: 16.1, produit: prestige.first])