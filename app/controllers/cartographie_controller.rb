class CartographieController < ApplicationController
  
  def index
    @clients = Client.find(:all, :conditions => ["is_livraison = 'f' and a_livrer = 't'"], :joins => :commande)
    @adresseOrigin = Parameter.findByName("default_adresse")
    @token = :carto
  end
end
