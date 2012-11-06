class CommandesController < ApplicationController
  # GET /commandes
  # GET /commandes.json
  def index
    @commandes = Commande.find(:all, :include => [:client])
    @token = :commandes

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @commandes }
    end
  end

  # GET /commandes/1
  # GET /commandes/1.json
  def show
    @commande = Commande.find(params[:id], :include => [:client])
    @commande.commande_produit = CommandeProduit.find(:all, :conditions => ['commande_id = ?', @commande], :include => [:produit])
    @token = :commandes

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @commande }
    end
  end

  # GET /commandes/new
  # GET /commandes/new.json
  def new
    @commande = Commande.new
    @commande.date_factu = Date.today.strftime('%d/%m/%Y')
    @commande.num_factu = Commande.next_num_factu
    # TODO : @commande.client_id = 2737
    Produit.all.each do |produit|
      @commande.commande_produit.push CommandeProduit.create_with_produit(@commande, produit)
      #@commande.commande_produit.build
    end
    @token = :commandes

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @commande }
    end
  end

  # GET /commandes/1/edit
  def edit
    @commande = Commande.find(params[:id], :include => [:client])
    @commande.commande_produit = CommandeProduit.find(:all, :conditions => ['commande_id = ?', @commande], :include => [:produit])
    @token = :commandes
  end

  # POST /commandes
  # POST /commandes.json
  def create
    @commande = Commande.new(params[:commande])
    @token = :commandes

      if @commande.save
        flash[:notice] = "Success"
        redirect_to commandes_path
      else
        #Produit.all.each do |produit|
        #  @commande.commande_produit.push CommandeProduit.create_with_produit(@commande, produit)
        #end
        render :action => "new"
      end

  end

  # PUT /commandes/1
  # PUT /commandes/1.json
  def update
    @commande = Commande.find(params[:id])
    @token = :commandes

    respond_to do |format|
      if @commande.update_attributes(params[:commande])
        format.html { redirect_to @commande, notice: 'Commande was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @commande.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commandes/1
  # DELETE /commandes/1.json
  def destroy
    @commande = Commande.find(params[:id])
    @commande.destroy
    @token = :commandes

    respond_to do |format|
      format.html { redirect_to commandes_url }
      format.json { head :no_content }
    end
  end
end
