class ClientsCleaningDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Client.count,
      iTotalDisplayRecords: clients.total_entries,
      aaData: data
    }
  end

private 

  def data
    clients.map do |client|
      geoLoc = "";
      if !client.cleaning
        cleaned = "<span class='label label-important'><abbr title='Pas de coordonn&eacute;es de g&eacute;olocalisation'>Error</aabr></span>"
      else
        cleaned = "<span class='label label-success'>OK</span>"        
      end
      
      [
        cleaned,
        client.num_client,
        client.nom,
        client.num_voie,
        client.codepostal,
        client.ville,
        if !client.pays.nil? then client.pays.nom else "" end,
        link_to('Nettoyer', "cleaning/edit/#{client.id}", class:"btn btn-primary")
      ]
    end
  end

  def clients
    @clients ||= fetch_clients
  end

  def fetch_clients
    clients = Client.order("#{sort_column} #{sort_direction}")
    clients = clients.page(page).per_page(per_page)
    if params[:sSearch].present?
      clients = clients.where("nom like :search or ville like :search", search: "%#{params[:sSearch]}%")
    end
    clients
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[cleaning num_client nom num_voie codepostal ville pays_id]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end