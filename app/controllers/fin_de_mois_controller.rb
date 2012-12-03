class FinDeMoisController < ApplicationController
  def index
    @produits = Produit.all
    @commandes = Commande.order("date_factu").find(:all, :conditions => ['date_factu is not null'])
    
    
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
