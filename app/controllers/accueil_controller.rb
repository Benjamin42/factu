class AccueilController < ApplicationController
  def index
    @client = Client.last
    @commande = Commande.last
    @bdl = Bdl.last
  end
end
