module CommandeStatsHelper
    
  def commandes_chart_series(commandes, start_time)
    orders_by_day = commandes.joins(:commande_produit).
                    where(:date_factu => start_time.beginning_of_day..Time.zone.now.end_of_day).
                    group("strftime('%m', date_factu)").
                    select("strftime('%m', date_factu) as short_date, sum(qty) as qty")
    (1..12).map do |date|
      commande = orders_by_day.detect { |orders| orders.short_date.to_i == date.to_i }
      commande && commande.qty || 0
    end.inspect
  end 
  
end
