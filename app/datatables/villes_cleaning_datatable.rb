class VillesCleaningDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: CleaningVille.count,
      iTotalDisplayRecords: cleaning_villes.total_entries,
      aaData: data
    }
  end

private 

  def data
    cleaning_villes.map do |ville|
   
      [
        ville.id,
        ville.nom,
        ville.nom_majuscule,
        ville.code_postal,
        ville.code_insee
      ]
    end
  end

  def cleaning_villes
    @cleaning_villes ||= fetch_cleaning_villes
  end

  def fetch_cleaning_villes
    cleaning_villes = CleaningVille.order("#{sort_column} #{sort_direction}")
    cleaning_villes = cleaning_villes.page(page).per_page(per_page)
    if params[:sSearch].present?
      cleaning_villes = cleaning_villes.where("nom like :search or nom_majuscule like :search or code_postal like :search", search: "%#{params[:sSearch]}%")
    end
    cleaning_villes
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[id nom nom_majuscule code_postal code_insee]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end