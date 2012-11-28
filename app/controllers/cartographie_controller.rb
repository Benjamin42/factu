class CartographieController < ApplicationController
  def index
    @clients = Client.find(:all, :conditions => ["is_livraison = 'f'"], :joins => :commande)
    @token = :carto
  end
end
