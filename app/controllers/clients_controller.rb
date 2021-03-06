# -*- coding: utf-8 -*-
require 'csv'

class ClientsController < ApplicationController

  # GET /clients
  # GET /clients.json
  def index
    @token = :clients

    respond_to do |format|
      format.html
      format.json { render json: ClientsDatatable.new(view_context) }
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @client = Client.find(params[:id])
    @token = :clients

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.json
  def new
    @client = Client.new
    @client.pays = CleaningPay.findByCode(Parameter.findByName("code_pays_defaut"))
    @client.num_client = Client.next_num_client
    @token = :clients

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id], :include => [:pays])
    @token = :clients
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(params[:client])
    @client.num_client = Client.next_num_client
    @client.long_adresse = Client.concatAddresse(@client)
    @token = :clients

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Client was successfully created.' }
        format.json { render json: @client, status: :created, location: @client }
      else
        format.html { render action: "new" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.json
  def update
    @client = Client.find(params[:id])
    @token = :clients

    respond_to do |format|
      if @client.update_attributes(params[:client])
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

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    @token = :clients

    respond_to do |format|
      format.html { redirect_to clients_url }
      format.json { head :no_content }
    end
  end

  def uploadFile
    @token = :clients
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
      client = Client.build_from_csv(row)
      # Save upon valid
      # otherwise collect error records to export
      if client.valid?
        client.save
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

    redirect_to "/clients"
  end
  
end
