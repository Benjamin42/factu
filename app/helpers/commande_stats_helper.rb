module CommandeStatsHelper

  def commandes_chart_series2(commandeProduits, start_time)
    orders_by_day = commandeProduits.joins(:commande).
                    where("commandes.date_factu" => start_time.beginning_of_day..Time.zone.now.end_of_day).
                    group("date(date_factu)").
                    select("date(date_factu) as dater, sum(qty) as qty")
    orders_by_day.map do |record|
      parts = %w[year month day].map{ |s| record.dater.to_date.send(s) }
      "[Date.UTC(#{parts.join(',')}),#{record.qty}]"
    end
  end  
end
