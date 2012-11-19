class CartographieController < ApplicationController
  def index
    @clients = Client.all
    @token = :carto
    
  end
end
