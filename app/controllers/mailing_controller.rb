class MailingController < ApplicationController
  
  def index
    @mailings = Mailing.order("id desc").find(:all, :include => [:statut])
    
    @token = :mailing
  end  
  
  def envoi
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
  
  
  def createDivToPrint
    listId = params[:listId]
    
    # Split sur la listId
    res = ""
    listId.split(",").each do |id|
      client = Client.find(id)
      
      res = "#{ res } #{ createDivForClient(client) }"
    end

    @msg = { "print" => res}

    respond_to do |format|
      format.html
      format.json { render json: @msg }
    end
  end  
  
  def createDivForClient(client)
    div = ""
        
    div = "#{ div } <div class='to_be_printed client'>"
    div = "#{ div } <div class='container-fluid'>"
    div = "#{ div }   <div class='row-fluid'>"
    div = "#{ div }     <div class='span6'>"
    div = "#{ div }       <div>"
    div = "#{ div }         <img src='/assets/logo.png'>"
    div = "#{ div }       </div>"
    div = "#{ div }     </div>"
        
    div = "#{ div }     <div class='span6'>"
    div = "#{ div }       <p>Soilly, le #{ DateTime.now.strftime('%d/%m/%Y') }</p>"
          
    div = "#{ div }       <br/>"
          
    div = "#{ div }       #{ client.nom }<br/>"
    if client.nom_info != nil
      div = "#{ div }         #{ client.nom_info }<br/>"
    end
    if client.bat != nil
      div = "#{ div }         #{ client.bat }<br/>"
    end
    if client.num_voie != nil
      div = "#{ div }         #{ client.num_voie }<br/>"
    end
    if client.bp != nil
      div = "#{ div }         #{ client.bp }<br/>"
    end
    if client.ville != nil
      div = "#{ div }         #{ client.ville }<br/>"
    end
    if client.pays != nil
      div = "#{ div }         #{ client.pays }<br/>"
    end
          
    div = "#{ div }     </div>"
    div = "#{ div }   </div>"
    div = "#{ div } </div>"
    
    div = "#{ div } <div class='container-fluid'>"
    div = "#{ div }   <div class='row-fluid'>"
    div = "#{ div }     <div class='span6'>"
    div = "#{ div }       <p>#{ Parameter.findByName('adresse_factu_rue') }</p>"
    div = "#{ div }       <p>#{ Parameter.findByName('adresse_factu_cp_ville') }</p>"
    div = "#{ div }       <p>Tel - Fax : #{ Parameter.findByName('tel') }</p>"
    div = "#{ div }     </div>"
    div = "#{ div }   </div>"
    div = "#{ div } </div>"
    
    div = "#{ div } <div><@ message @></div>"
    
    div = "#{ div } </div>"
    return div
  end   
end
