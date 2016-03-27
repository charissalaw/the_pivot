class Borrower::LoansController < ApplicationController
  def index
    @loans = current_user.loans.by_date
    if params[:status]
      @loans = current_user.loans.where(status: params[:status]).by_date.limit(50)
    elsif params[:id_search]
      if current_user.loans.exists?(params[:id_search])
        redirect_to borrower_user_loan(params[:id_search])
      else
        flash.now[:alert] = "Loan #{params[:id_search]}  doesn't exist silly!"
        render :index
      end
    elsif params[:search]
      @loans = current_user.loans.search(params[:search]).by_date
    elsif params[:date_search]
      @loans = current_user.loans.search_by_date(params[:date_search])
    end
  end

  def show
  end
end
