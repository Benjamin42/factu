class FinDeMoisController < ApplicationController
  def index
    @produits = Produit.all
    @commandes = Commande.order("date_factu").find(:all, :conditions => ['date_factu is not null'])
    
    listSql = CommandeProduit.listForFinDeMois
    
    @hashLine = Hash.new
    @hashLineTotal = Hash.new
    listSql.each do |t|
      if params["dateFilter"] == nil || /#{params["dateFilter"]}/.match(Date.parse(t.dater).strftime('%d/%m/%Y'))
        line = nil
        if t.num_bdl != nil
          line = @hashLine["bdl_#{t.num_bdl}"]
        else 
          line = @hashLine["cmd_#{t.num_factu}"]
         end
        
        if line == nil
          line = FinDeMois.new(t.num_bdl, t.num_factu, Date.parse(t.dater))
        end
        
        line.addProduit(t.label, t.qty, t.qty_cadeau)
        if @hashLineTotal[t.label] == nil
          @hashLineTotal[t.label] = if t.qty.nil? then 0 else t.qty end + if t.qty_cadeau.nil? then 0 else t.qty_cadeau end
        else
          @hashLineTotal[t.label] = @hashLineTotal[t.label] + if t.qty.nil? then 0 else t.qty end + if t.qty_cadeau.nil? then 0 else t.qty_cadeau end
        end
        
        if t.num_bdl != nil
          @hashLine["bdl_#{t.num_bdl}"] = line
        else
          @hashLine["cmd_#{t.num_factu}"] = line
        end
        
      end
    end
    
    # Liste des mois d'une année (pas très beau)
    @tabMonth = Hash.new
    @tabMonth[""] = ""
    (1..12).each() do |id|
      @tabMonth[Date.parse("27/#{id}/1983").strftime('%B')] = id
    end
    
    @tabYear = Hash.new
    @tabYear[""] = ""
    (2010..2020).each() do |id|
      @tabYear[id] = id
    end
    
    @token = :finDeMois
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hashLine }
      format.xls
    end
  end

end
