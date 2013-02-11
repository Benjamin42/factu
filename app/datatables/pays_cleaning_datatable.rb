class PaysCleaningDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: CleaningPay.count,
      iTotalDisplayRecords: cleaning_pays.total_entries,
      aaData: data
    }
  end

private 

  def data
    cleaning_pays.map do |pays|
   
      [
        pays.id,
        pays.nom,
        pays.code_pays
      ]
    end
  end

  def cleaning_pays
    @cleaning_pays ||= fetch_cleaning_pays
  end

  def fetch_cleaning_pays
    cleaning_pays = CleaningPay.order("#{sort_column} #{sort_direction}")
    cleaning_pays = cleaning_pays.page(page).per_page(per_page)
    if params[:sSearch].present?
      cleaning_pays = cleaning_pays.where("nom like :search or code_pays like :search", search: "%#{params[:sSearch]}%")
    end
    cleaning_pays
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[id nom code_pays]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end