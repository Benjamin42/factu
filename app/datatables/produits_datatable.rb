class ProduitsDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Produit.count,
      iTotalDisplayRecords: produits.total_entries,
      aaData: data
    }
  end

private 

  def data
    produits.map do |produit|
      [
        link_to(produit.label, produit),
        h(produit.label),
      ]
    end
  end

  def produits
    @produits ||= fetch_produits
  end

  def fetch_produits
    produits = Produit.order("#{sort_column} #{sort_direction}")
    produits = produits.page(page).per_page(per_page)
    if params[:sSearch].present?
      produits = produits.where("label like :search", search: "%#{params[:sSearch]}%")
    end
    produits
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[label]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end