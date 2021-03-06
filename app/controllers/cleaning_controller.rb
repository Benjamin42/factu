# -*- coding: utf-8 -*-
require 'csv'
require 'Cleaning'

class CleaningController < ApplicationController
  include Cleaning
  
  def index
    @token = :cleaning
    
    respond_to do |format|
      format.html
      format.json { render json: ClientsCleaningDatatable.new(view_context) }
    end
  end
  
  # GET /cleaning/1/edit
  def edit
    @client = Client.find(params[:id])
    
    @oldClient = Hash.new
    @oldClient["num_tva"] = @client.num_tva
    if @client.civilite_id != nil
      @oldClient["civilite"] = Type.find(@client.civilite_id).label
    end
    @oldClient["nom"] = @client.nom
    @oldClient["prenom"] = @client.prenom
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
    
    if @client.cleaning != true
      clean @client
    end
    
    @token = :cleaning
  end  
  
  # PUT /cleaning/1
  # PUT /cleaning/1.json
  def update
    @client = Client.find(params[:id])
    
    @oldClient = Hash.new
    @oldClient["num_tva"] = @client.num_tva
    if @client.civilite_id != nil
      @oldClient["civilite"] = Type.find(@client.civilite_id).label
    end
    @oldClient["nom"] = @client.nom
    @oldClient["prenom"] = @client.prenom
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
    
    @token = :cleaning

    respond_to do |format|
      if @client.update_attributes(params[:client])
        @client.cleaning = true
        @client.long_adresse = Client.concatAddresse(@client)
        @client.save
        @clients = Client.find(:all, :include => [:pays])
        flash[:notice] = "Client was successfully updated."
        format.html { redirect_to "/cleaning" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end
  

end
