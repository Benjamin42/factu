class MailingController < ApplicationController
  def index
    @clients = Client.all
    @mailing = Mailing.find(:first, :conditions => ["statut_id = ?", Type.findAllWithGroupeAndCode("mailingStatut", "Tmp")])
    
    @token = :mailing
  end
  
  def saveBrouillon
    message = params[:message]

    @mailing = Mailing.find(:first, :conditions => ["statut_id = ?", Type.findAllWithGroupeAndCode("mailingStatut", "Tmp")])
    if @mailing.nil?
      @mailing = Mailing.new
    end
    @mailing.t_texte = params[:message]
    @mailing.statut = Type.findAllWithGroupeAndCode("mailingStatut", "Tmp")
    @token = :mailing
    
    if @mailing.save
      @msg = { "success" => "true"}
    else
      @msg = { "success" => "false"}
    end
    respond_to do |format|
      format.html
      format.json { render json: @msg }
    end
  end  
  
  def saveEnvoi
    message = params[:message]

    @mailing = Mailing.find(:first, :conditions => ["statut_id = ?", Type.findAllWithGroupeAndCode("mailingStatut", "Tmp")])
    if @mailing.nil?
      @mailing = Mailing.new
    end
    @mailing.t_texte = params[:message]
    @mailing.statut = Type.findAllWithGroupeAndCode("mailingStatut", "Env")
    @token = :mailing
    
    if @mailing.save
      @msg = { "success" => "true"}
    else
      @msg = { "success" => "false"}
    end
    respond_to do |format|
      format.html
      format.json { render json: @msg }
    end
  end    
  
end
