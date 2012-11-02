class ProduitsController < ApplicationController
  # GET /produits
  # GET /produits.json
  def index
    @produits = Produit.all
    @token = :produits

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: ProduitsDatatable.new(view_context) }
    end
  end

  # GET /produits/1
  # GET /produits/1.json
  def show
    @produit = Produit.find(params[:id])
    @token = :produits

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @produit }
    end
  end

  # GET /produits/new
  # GET /produits/new.json
  def new
    @produit = Produit.new
    @token = :produits

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @produit }
    end
  end

  # GET /produits/1/edit
  def edit
    @produit = Produit.find(params[:id])
    @token = :produits
  end

  # POST /produits
  # POST /produits.json
  def create
    @produit = Produit.new(params[:produit])
    @token = :produits

    respond_to do |format|
      if @produit.save
        listAnnee = Tarif.list_annee
        listAnnee.each do |anneeLine|
          tarif = Tarif.create_tarif(@produit, anneeLine.annee)
          tarif.save
        end
        format.html { redirect_to @produit, notice: 'Produit was successfully created.' }
        format.json { render json: @produit, status: :created, location: @produit }
      else
        format.html { render action: "new" }
        format.json { render json: @produit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /produits/1
  # PUT /produits/1.json
  def update
    @produit = Produit.find(params[:id])
    @token = :produits

    respond_to do |format|
      if @produit.update_attributes(params[:produit])
        format.html { redirect_to @produit, notice: 'Produit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @produit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /produits/1
  # DELETE /produits/1.json
  def destroy
    @produit = Produit.find(params[:id])
    Tarif.delete_tarif(params[:id])
    @produit.destroy
    @token = :produits

    respond_to do |format|
      format.html { redirect_to produits_url }
      format.json { head :no_content }
    end
  end
end
