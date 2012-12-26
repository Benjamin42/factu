class CleaningController < ApplicationController
  include Cleaning
  
  def index
    @clients = Client.all
    @token = :cleaning
  end
  
  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
    
    @oldClient = Hash.new
    @oldClient["num_tva"] = @client.num_tva
    if @client.num_tva != nil
      @oldClient["civilite"] = Type.find(@client.civilite_id).label
    end
    @oldClient["nom"] = @client.nom
    @oldClient["nom_info"] = @client.nom_info
    @oldClient["bat"] = @client.bat
    @oldClient["num_voie"] = @client.num_voie
    @oldClient["bp"] = @client.bp
    @oldClient["codepostal"] = @client.codepostal
    @oldClient["ville"] = @client.ville
    @oldClient["pays"] = @client.pays
    @oldClient["tel"] = @client.tel
    @oldClient["portable"] = @client.portable
    @oldClient["fax"] = @client.fax
    @oldClient["email"] = @client.email
    @oldClient["commentaire"] = @client.commentaire
    
    clean @client
    
    @token = :cleaning
  end  
end
