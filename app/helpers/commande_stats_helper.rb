module CommandeStatsHelper
    
  def commandes_chart_series2(commandes, start_time)
    orders_by_day = commandes.joins(:commande_produit).
                    where(:date_factu => start_time.beginning_of_day..Time.zone.now.end_of_day).
                    group("strftime('%m', date_factu)").
                    select("strftime('%m', date_factu) as date_factu, sum(qty) as qty")
    (1..12).map do |date|
      commande = orders_by_day.detect { |orders| orders.date_factu != nil && orders.date_factu.to_str == date.to_str }
      commande && commande.qty || 0
    end.inspect
  end 
  
  def commandes_chart_series(commandes, start_time)
    orders_by_day = commandes.joins(:commande_produit).
                    where(:date_factu => start_time.beginning_of_day..Time.zone.now.end_of_day).
                    group("strftime('%m', date_factu)").
                    select("strftime('%m', date_factu) as date_factu, sum(nb_etiquette) as nb_etiquette")
    (1..12).map do |date|
      commande = orders_by_day.detect { |orders| orders.date_factu != nil && orders.date_factu.to_str == date.to_str }
      commande && commande.nb_etiquette || 0
    end.inspect
  end   
end
