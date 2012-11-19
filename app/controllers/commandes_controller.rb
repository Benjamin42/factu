# encoding: utf-8
require 'csv'

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
  
  def new_with_client
    @commande = Commande.new
    @commande.date_factu = Date.today.strftime('%d/%m/%Y')
    @commande.num_factu = Commande.next_num_factu
    @commande.client_id = params[:id]
    Produit.all.each do |produit|
      @commande.commande_produit.push CommandeProduit.create_with_produit(@commande, produit)
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
      @commande.commande_produit.push CommandeProduit.create_with_produit(@commande, produit)
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
        render :action => "show"
      else
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
  
  # GET /facturation/1
  # GET /facturation/1.json
  def facturation
    @commande = Commande.find(params[:id], :include => [:client])
    @commande.commande_produit = CommandeProduit.find(:all, :conditions => ['commande_id = ?', @commande], :include => [:produit, :tarif])
    @token = :commandes

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @commande }
    end
  end
end
