class MailingController < ApplicationController
  def index
    @clients = Client.all
    
    @token = :mailing
  end
end
