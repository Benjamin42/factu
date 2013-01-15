# -*- coding: utf-8 -*-

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Client.delete_all
Produit.delete_all
Tarif.delete_all
CommandeProduit.delete_all
Commande.delete_all

bouteille = Produit.create([label: 'Bouteille', commentaire: '', id_columns_factu_csv: 5])
demi = Produit.create([label: 'Demi Bouteille', commentaire: '', id_columns_factu_csv: 7])
magnum = Produit.create([label: 'Magnum', commentaire: '', id_columns_factu_csv: 9])
jero = Produit.create([label: 'Jéroboam', commentaire: '', id_columns_factu_csv:17])
mathu = Produit.create([label: 'Mathusalem', commentaire: '', id_columns_factu_csv:19])
privilege = Produit.create([label: 'Privilège', commentaire: 'La bouteille', id_columns_factu_csv:15])
rose = Produit.create([label: 'Rosé', commentaire: 'La bouteille', id_columns_factu_csv: 13])
prestige = Produit.create([label: 'Prestige', commentaire: 'La bouteille', id_columns_factu_csv: 11])

Parameter.create([p_name: 'default_adresse', p_value: '11 rue des Ternes Paris', grp: 'carto'])
Parameter.create([p_name: 'tva', p_value: '19.6', grp: 'factu'])
Parameter.create([p_name: 'adresse_factu_rue', p_value: '18 rue Franche', grp: 'factu'])
Parameter.create([p_name: 'adresse_factu_cp_ville', p_value: '51700 Soilly-Dormans', grp: 'factu'])
Parameter.create([p_name: 'tel', p_value: '03.26.58.82.89', grp: 'factu'])
Parameter.create([p_name: 'num_rc', p_value: 'RC-20715-01', grp: 'factu'])
Parameter.create([p_name: 'num_siret', p_value: '35059931900012', grp: 'factu'])
Parameter.create([p_name: 'code_tva', p_value: 'FR 36 350 599 379 0001', grp: 'factu'])
Parameter.create([p_name: 'reglement1', p_value: 'Acceptant le rêglement des sommes dues par chèque libellé à son nom en sa qualité de membre d''un centre de gestion agréé par l''administration Fiscale.', grp: 'factu'])
Parameter.create([p_name: 'reglement2', p_value: 'En cas de non respect des délais de paiement : pénalité égale au taux légal majoré de 50%.', grp: 'factu'])
Parameter.create([p_name: 'reglement3', p_value: 'Nos vins, quel que soit le mode d''achat, voyageant aux risques et périls du destinataire, la vérification des colis à la réception est indispensable, faire toutes réserves auprès du transporteur en cas de manquant ou d''avarie.', grp: 'factu'])
Parameter.create([p_name: 'reglement4', p_value: 'Nos marchandises sont payables à SOILLY. ', grp: 'factu'])
Parameter.create([p_name: 'reglement5', p_value: 'En cas de non respect des délais de paiement : pénalité égale au taux légal majoré de 50%.', grp: 'factu'])
Parameter.create([p_name: 'code_pays_defaut', p_value: 'FR', grp: 'client'])

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


Type.create([label: 'Monsieur', code: 'Mr', grp: 'civilite'])
Type.create([label: 'Madame', code: 'Mme', grp: 'civilite'])
Type.create([label: 'Mademoiselle', code: 'Mlle', grp: 'civilite'])
Type.create([label: 'Entreprise', code: 'Ent', grp: 'civilite'])

Type.create([label: 'Brouillon', code: 'Tmp', grp: 'mailingStatut'])
Type.create([label: 'Envoy&eacute;', code: 'Env', grp: 'mailingStatut'])
