# -*- coding: utf-8 -*-
require 'csv'

class CleaningController < ApplicationController
  include Cleaning
  
  def index
    @clients = Client.find(:all, :include => [:pays])
    
    @token = :cleaning
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
    @token = :cleaning

    respond_to do |format|
      if @client.update_attributes(params[:client])
        @client.cleaning = true
        @client.long_adresse = Client.concatAddresse(@client)
        @client.save
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end
  

end
