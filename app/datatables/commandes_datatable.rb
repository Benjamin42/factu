class CommandesDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Commande.count,
      iTotalDisplayRecords: commandes.total_entries,
      aaData: data
    }
  end

private 

  def data
    commandes.map do |commande|
      [
        commande.num_factu,
        if commande.client != nil then commande.client.printable_name else "" end,
        if commande.date_factu != nil then commande.date_factu.strftime('%d/%m/%Y') else "" end,
        if commande.date_livraison != nil then commande.date_livraison.strftime('%d/%m/%Y') else "" end,
        if commande.date_paiement != nil then commande.date_paiement.strftime('%d/%m/%Y') else "" end,
        commande.qtyTotal,
        link_to('Facture', "commandes/facturation/#{commande.id}", class:"btn btn-inverse"),
        link_to('Afficher', commande, class:"btn btn-info"),
        if !commande.is_freeze then link_to('Editer', "/commandes/#{ commande.id}/edit", class:"btn btn-warning") else link_to('Defreezer', "commandes/defreeze/#{ commande.id }", class:"btn btn-danger") end,
        link_to('Supprimer', commande, confirm: 'Etes vous sur ?', method: :delete, class:"btn btn-danger"),
      ]
    end
  end

  def commandes
    @commandes ||= fetch_commandes
  end

  def fetch_commandes
    commandes = Commande.joins(:client).order("#{sort_column} #{sort_direction}")
    commandes = commandes.page(page).per_page(per_page)
    if params[:sSearch].present?
      commandes = commandes.where("clients.nom like :search ", search: "%#{params[:sSearch]}%")
    end
    commandes
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[num_factu clients.nom date_factu date_livraison date_paiement]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end