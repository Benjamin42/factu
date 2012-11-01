class TarifsController < ApplicationController
  attr_accessor :token
  # GET /tarifs
  # GET /tarifs.json
  def index
    @produits = Produit.all
    @tarifs = Tarif.hash_year
    @token = :tarifs

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tarifs }
    end
  end

  # GET /tarifs/1
  # GET /tarifs/1.json
  def show
    @tarif = Tarif.find(params[:id])
    @token = :tarifs

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tarif }
    end
  end

  # GET /tarifs/new
  # GET /tarifs/new.json
  def new
    @produits = Produit.all
    anneeSuivante = Tarif.annee_suivante
    @produits.each do |produit|
      tarif = Tarif.create_tarif(produit, anneeSuivante)
      tarif.save
    end
    
     redirect_to "/tarifs"
  end

  # GET /tarifs/1/edit
  def edit
    @tarif = Tarif.find(params[:id], :include => [:produit])
    @token = :tarifs
    @content_type_options = Produit.all
  end


  # PUT /tarifs/1
  # PUT /tarifs/1.json
  def update
    @tarif = Tarif.find(params[:id])
    @token = :tarifs

    respond_to do |format|
      if @tarif.update_attributes(params[:tarif])
        format.html { redirect_to @tarif, notice: 'Tarif was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tarif.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tarifs/1
  # DELETE /tarifs/1.json
  def destroy
    @tarifs = Tarif.find(:all, :conditions => "annee = #{params[:id]}")
    @tarifs.each do |tarif|
      tarif.destroy
    end
    @token = :tarifs

    respond_to do |format|
      format.html { redirect_to tarifs_url }
      format.json { head :no_content }
    end
  end
end
