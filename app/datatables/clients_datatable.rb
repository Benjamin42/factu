class ClientsDatatable
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
      [
        h(client.num_client),
        h(client.nom),
        h(client.num_voie),
        h(client.ville),
        h(client.pays),
        h(client.email),
        h(client.longitude),
        h(client.latitude),
        link_to("Commande", "commandes/new_with_client/#{client.id}",  class: "btn btn-primary"),
        link_to("Show", client, class: "btn btn-info"),
        link_to("Edit", "clients/#{client.id}/edit", class: "btn btn-warning"),
        link_to("Destroy", client, confirm: 'Are you sure?', method: :delete, class: "btn btn-danger"),
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
    columns = %w[num_client nom num_voie ville pays email longitude latitude]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end