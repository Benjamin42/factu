# encoding: utf-8
require 'csv'

class CommandesController < ApplicationController
  layout proc{ |c| c.request.xhr? ? false : "application" }
  
  # GET /commandes
  # GET /commandes.json
  def index
    @q= Commande.search(params[:q], :include => [:client])
    @commandes = @q.result
    @token = :commandes

    respond_to do |format|
      format.html
      format.json { render json: CommandesDatatable.new(view_context) }
    end
  end

  # GET /commandes/1
  # GET /commandes/1.json
  def show
    @commande = Commande.find(params[:id], :include => [:client])
    @commande.commande_produit = CommandeProduit.find(:all, :conditions => ['commande_id = ?', @commande], :include => [:produit])
    @commande.commande_service = CommandeService.find(:all, :conditions => ['commande_id = ?', @commande], :include => [:service])
    @token = :commandes

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @commande }
    end
  end

  def defreeze
    @commande = Commande.find(params[:id])
    @commande.commande_produit = CommandeProduit.find(:all, :conditions => ['commande_id = ?', @commande], :include => [:produit])
    @commande.commande_service = CommandeService.find(:all, :conditions => ['commande_id = ?', @commande], :include => [:service])
    
    @commande.is_freeze = false
    @commande.save
    
    @token = :commandes
    
    @q= Commande.search(params[:q], :include => [:client])
    @commandes = @q.result
    
    render :action => "index"
  end
  
  def new_with_client
    @commande = Commande.new
    @commande.date_factu = Date.today.strftime('%d/%m/%Y')
    @commande.num_factu = Commande.next_num_factu
    @commande.client = Client.find(params[:id])
    Produit.all.each do |produit|
      @commande.commande_produit.push CommandeProduit.create_with_produit(@commande, nil, produit)
    end
    Service.all.each do |service|
      @commande.commande_service.push CommandeService.create_with_service(@commande, nil, service)
    end    
    
    @token = :commandes

    render :action => "new"
  end

  # GET /commandes/new
  # GET /commandes/new.json
  def new(idClient=nil)
    @commande = Commande.new
    @commande.date_factu = Date.today.strftime('%d/%m/%Y')
    @commande.num_factu = Commande.next_num_factu
    Produit.all.each do |produit|
      @commande.commande_produit.push CommandeProduit.create_with_produit(@commande, nil, produit)
    end
    Service.all.each do |service|
      @commande.commande_service.push CommandeService.create_with_service(@commande, nil, service)
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
    @commande.commande_service = CommandeService.find(:all, :conditions => ['commande_id = ?', @commande], :include => [:service])
    @token = :commandes
  end

  # POST /commandes
  # POST /commandes.json
  def create
    @commande = Commande.new(params[:commande])
    @commande.is_freeze = @commande.mustBeFreeze
    @commande.save
    @token = :commandes

      if @commande.save
        flash[:notice] = "Success"
        createVarForFactu
        redirect_to "/commandes/facturation/#{ @commande.id }"
      else
        @commande.commande_produit.each do |cp|
          cp.destroy
        end
        @commande.commande_service.each do |cs|
          cs.destroy
        end
        render :action => "new"
      end

  end

  # PUT /commandes/1
  # PUT /commandes/1.json
  def update
    @commande = Commande.find(params[:id])
    @commande.commande_produit = CommandeProduit.find(:all, :conditions => ['commande_id = ?', @commande], :include => [:produit])
    @commande.commande_service = CommandeService.find(:all, :conditions => ['commande_id = ?', @commande], :include => [:service])
    @token = :commandes

    respond_to do |format|
      if @commande.update_attributes(params[:commande])
        @commande.is_freeze = @commande.mustBeFreeze
        @commande.save
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
    produits = CommandeProduit.find(:all, :conditions => ['commande_id = ?', @commande], :include => [:produit])
    produits.each do |p|
      p.destroy
    end
    services = CommandeService.find(:all, :conditions => ['commande_id = ?', @commande], :include => [:service])
    services.each do |s|
      s.destroy
    end
    @commande.destroy
    @token = :commandes

    respond_to do |format|
      format.html { redirect_to(params[:redirect_to] || commandes_url) }
      format.json { head :no_content }
    end
  end
  
  def uploadFile
    @token = :commandes
    file_data = params[:my_file]
    errs = []

    if file_data.respond_to?(:read)
      csv_contents = file_data.read
    elsif file_data.respond_to?(:path)
      csv_contents = File.read(file_data.path)
    else
      logger.error "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
    end

    CSV.parse(csv_contents, {:headers => true, :col_sep => ";", :quote_char => '"'}) do |row|
      commande = Commande.build_from_csv(row)
      if commande != nil && commande.valid?
        commande.save
        Produit.all.each do |produit|
          if produit.id_columns_factu_csv != nil
            commandeProduit = CommandeProduit.build_from_csv(row, commande, produit)
            if commandeProduit.valid?
              commandeProduit.save
              commande.commande_produit.push commandeProduit
            else
              errs << row
            end
          end
        end        
        
      else
        errs << row
      end
    end

    File.open(Rails.root.join('public', 'uploads', "#{Date.today.strftime('%d%m%y')}_" + file_data.original_filename), 'w') do |file|
      file.write(file_data.read)
    end

    # Export Error file for later upload upon correction
    if errs.any?
      flash[:error] = "File has been uploaded with errors."
    else
    #I18n.t('customer.import.success')
      flash[:notice] = "File has been uploaded successfully"
    end

    redirect_to "/commandes"
  end
  
  def createVarForFactu
    @totalTTC = 0
    @commande.commande_produit = CommandeProduit.find(:all, :conditions => ['commande_id = ?', @commande], :include => [:produit, :tarif])
    @commande.commande_produit.each do |cp|
      @totalTTC += cp.calcMontantTTC
    end
    
    @commande.commande_service = CommandeService.find(:all, :conditions => ['commande_id = ?', @commande], :include => [:service])
    @commande.commande_service.each do |cs|
      @totalTTC += cs.montant
    end
    
    @totalTVA = (@totalTTC - @totalTTC * 100 / (100 + Parameter.findByName("tva").to_f)).round(2)
    
    @gift = false
    @commande.commande_produit.each do |cp|
      if cp.qty_cadeau > 0
        @gift = true
      end
    end
  end
  
  # GET /facturation/1
  # GET /facturation/1.json
  def facturation
    @commande = Commande.find(params[:id], :include => [:client])
    
    createVarForFactu

    @token = :commandes

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @commande }
    end
  end
  
  def facture
    @commande = Commande.find(params[:id])
    @commande.date_factu = DateTime.now
    @commande.is_freeze = true
    @commande.save

    redirect_to "/commandes/facturation/#{ @commande.id }"
  end
  
  def bar
    @bdl = Bdl.find(params[:id])

    tabOrigin = ""
    
    result = CommandeProduit.getTotalRestBdl(@bdl)
    
    result.each do |res|
      if res.qty != nil && res.qty != 0
        tabOrigin += "<tr><td>#{res.label}</td><td>#{res.qty}</td><td><b>#{res.rest}</b></td></tr>"
      end
    end
    
    @msg = { "success" => "true", "labelBdl" => @bdl.label, "idClient" => @bdl.client_id, "tabOrigin" => tabOrigin}
    respond_to do |format|
      format.html
      format.json { render json: @msg }
    end
  end

end
