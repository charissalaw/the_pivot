class Admin::BorrowersController < ApplicationController
  def index
    @borrowers = Borrower.by_date
    if params[:id_search]
      if Borrower.exists?(params[:id_search])
        redirect_to admin_borrower_path(params[:id_search])
      else
        flash.now[:alert] = "Borrower #{params[:id_search]}  doesn't exist!"
        render :index
      end
    elsif params[:search]
      @borrowers = Borrower.search(params[:search]).by_date
    elsif params[:category_search]
      @borrowers = Borrower.search_by_category(params[:category_search]).by_date
    elsif params[:date_search]
      @borrowers = Borrower.search_by_date(params[:date_search])
    elsif params[:country_search]
      @borrowers = Borrower.search_by_country(params[:country_search])
    end
  end

  def show

  end
end
