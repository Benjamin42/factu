class BdlsController < ApplicationController
  # GET /bdls
  # GET /bdls.json
  def index
    @bdls = Bdl.all
    @token = :bdls
    
    @commandeHash = Bdl.getAllCommandeProduit

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bdls }
    end
  end

  # GET /bdls/1
  # GET /bdls/1.json
  def show
    @bdl = Bdl.find(params[:id])
    @bdl.commande_produit = CommandeProduit.find(:all, :conditions => ['bdl_id = ?', @bdl], :include => [:produit])
    @bdl.commande_service = CommandeService.find(:all, :conditions => ['bdl_id = ?', @bdl], :include => [:service])
    @token = :bdls

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bdl }
    end
  end
  
  def new_with_client
    @bdl = Bdl.new
    @bdl.date_bdl = Date.today.strftime('%d/%m/%Y')
    @bdl.num_bdl = Bdl.next_num_bdl
    @bdl.client_id = params[:id]
    Produit.all.each do |produit|
      @bdl.commande_produit.push CommandeProduit.create_with_produit(nil, @bdl, produit)
    end
    Service.all.each do |service|
      @bdl.commande_service.push CommandeService.create_with_service(nil, @bdl, service)
    end    
    @token = :bdls

    render :action => "new"
  end  

  # GET /bdls/new
  # GET /bdls/new.json
  def new
    @bdl = Bdl.new
    @bdl.date_bdl = Date.today.strftime('%d/%m/%Y')
    @bdl.num_bdl = Bdl.next_num_bdl
    Produit.all.each do |produit|
      @bdl.commande_produit.push CommandeProduit.create_with_produit(nil, @bdl, produit)
    end
    Service.all.each do |service|
      @bdl.commande_service.push CommandeService.create_with_service(nil, @bdl, service)
    end    
    @token = :bdls

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bdl }
    end
  end

  # GET /bdls/1/edit
  def edit
    @bdl = Bdl.find(params[:id], :include => [:client])
    @bdl.commande_produit = CommandeProduit.find(:all, :conditions => ['bdl_id = ?', @bdl], :include => [:produit])
    @bdl.commande_service = CommandeService.find(:all, :conditions => ['bdl_id = ?', @bdl], :include => [:service])
    @token = :bdls
  end

  # POST /bdls
  # POST /bdls.json
  def create
    @bdl = Bdl.new(params[:bdl])
    @token = :bdls

      if @bdl.save
        flash[:notice] = "Success"
        render :action => "show"
      else
        @bdl.commande_produit.each do |cp|
          cp.destroy
        end
        @bdl.commande_service.each do |cs|
          cs.destroy
        end        
        render :action => "new"
      end
  end

  # PUT /bdls/1
  # PUT /bdls/1.json
  def update
    @bdl = Bdl.find(params[:id])
    @bdl.commande_produit = CommandeProduit.find(:all, :conditions => ['bdl_id = ?', @bdl], :include => [:produit])
    @bdl.commande_service = CommandeService.find(:all, :conditions => ['bdl_id = ?', @bdl], :include => [:service])
    @token = :bdls

    respond_to do |format|
      if @bdl.update_attributes(params[:bdl])
        format.html { redirect_to @bdl, notice: 'Bdl was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bdl.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bdls/1
  # DELETE /bdls/1.json
  def destroy
    @bdl = Bdl.find(params[:id])
    @bdl.destroy
    @token = :bdls

    respond_to do |format|
      format.html { redirect_to bdls_url }
      format.json { head :no_content }
    end
  end
  
  # GET /impression/1
  # GET /impression/1.json
  def impression
    @bdl = Bdl.find(params[:id], :include => [:client])
    
    @totalTTC = 0
    @bdl.commande_produit = CommandeProduit.find(:all, :conditions => ['bdl_id = ?', @bdl], :include => [:produit, :tarif])
    @bdl.commande_produit.each do |cp|
      @totalTTC += cp.calcMontantTTC
    end    
    @bdl.commande_service = CommandeService.find(:all, :conditions => ['bdl_id = ?', @bdl], :include => [:service])
    @bdl.commande_service.each do |cs|
      @totalTTC += cs.montant
    end    
    
    @totalTVA = (@totalTTC - @totalTTC * 100 / (100 + Parameter.findByName("tva").to_f)).round(2)
    
    @gift = false
    @bdl.commande_produit.each do |cp|
      if cp.qty_cadeau > 0
        @gift = true
      end
    end
    
    @token = :bdls

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bdl }
    end
  end  
end
