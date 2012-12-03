class FinDeMoisController < ApplicationController
  def index
    @produits = Produit.all
    @commandes = Commande.order("date_factu").find(:all, :conditions => ['date_factu is not null'])
    
    
    tmp = CommandeProduit.find_by_sql("SELECT num_bdl, num_factu, label, qty, qty_cadeau, dater FROM (
      SELECT null as num_bdl, num_factu as num_factu, P.label, qty, qty_cadeau, date_factu as dater FROM COMMANDE_PRODUITS CP
        JOIN COMMANDES C ON C.id = CP.commande_id
        JOIN PRODUITS P ON P.id = CP.produit_id
        WHERE C.bdl_id is null
      UNION ALL
      SELECT num_bdl as num_bdl, null as num_factu, P.label, qty, qty_cadeau, date_bdl as dater FROM COMMANDE_PRODUITS CP
        JOIN BDLS B ON B.id = CP.bdl_id
        JOIN PRODUITS P ON P.id = CP.produit_id
      ) ORDER BY dater")
    
    @hashLine = Hash.new
    tmp.each do |t|
      line = nil
      if t.num_bdl != nil
        line = @hashLine["bdl_#{t.num_bdl}"]
      else 
        line = @hashLine["cmd_#{t.num_factu}"]
       end
      
      if line == nil
        line = FinDeMois.new(t.num_bdl, t.num_factu, t.dater)
      end
      
      line.addProduit(t.label, t.qty, t.qty_cadeau)
      
      
      if t.num_bdl != nil
        @hashLine["bdl_#{t.num_bdl}"] = line
      else
        @hashLine["cmd_#{t.num_factu}"] = line
      end
      
    end
    
    
    @hash = Hash.new
    
    CommandeProduit.find(:all, :include => [:produit]).each do |cP|
      hashProduit = nil
      if @hash[cP.commande_id] != nil then
        hashProduit = @hash[cP.commande_id]
      else
        hashProduit = Hash.new
      end
      
      hashProduit[cP.produit.label] = (cP.qty != nil ? cP.qty : 0) + (cP.qty_cadeau != nil ? cP.qty_cadeau : 0)
      @hash[cP.commande_id] = hashProduit
    end 
    
    @tabMonth = Hash.new
    (1..12).each() do |id|
      @tabMonth[Date.parse("27/#{id}/1983").strftime('%B')] = id
    end
    
    
    @token = :finDeMois
  end
end
