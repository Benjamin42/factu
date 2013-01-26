class AccueilController < ApplicationController
  def index
    @client = Client.last
  end
end
