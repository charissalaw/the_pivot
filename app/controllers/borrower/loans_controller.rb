class Borrower::LoansController < ApplicationController
  def index
    if params[:status] == "active"
      @loans = current_user.borrower.loans.active_loans
    else
      @loans = current_user.borrower.loans.completed_loans
    end
  end

  def show
  end
end
