class Search
  def self.admin_projects(params)
    if params[:status] == "completed"
      Project.completed_index
    elsif params[:status] == "deactive"
      Project.inactive_index
    elsif params[:status] == "active"
      Project.active_index
    elsif params[:search]
      Project.search(params[:search]).by_date
    elsif params[:category_search]
      Project.search_by_category(params[:category_search]).by_date
    elsif params[:country_search]
      Project.search_by_country(params[:country_search])
    end
  end

  def self.admin_borrowers(params)
    if params[:search]
      Borrower.search(params[:search]).by_date
    elsif params[:category_search]
      Borrower.search_by_category(params[:category_search]).by_date
    elsif params[:date_search]
      Borrower.search_by_date(params[:date_search])
    elsif params[:country_search]
      Borrower.search_by_country(params[:country_search])
    elsif params[:tag]
      Borrower.by_date
    end
  end
end
