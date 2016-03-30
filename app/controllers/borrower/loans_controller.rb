class Borrower::LoansController < ApplicationController
  def index
    if params[:status] == "completed"
      @projects = current_user.projects
    else
      @projects = current_user.projects
    end
  end

  def show
    @loan = Loan.find(params[:id])
    @project = Project.find(@loan.project_id)
  end

  def update
    @loan = Loan.find(params[:loan_id])
    subtract_amt = params[:amount]
    amt_remaining = @loan.quantity - subtract_amt.to_i
    @loan.update(quantity: amt_remaining)
    redirect_to borrower_user_loans_path(current_user)
    flash[:info] = "You have paid $#{subtract_amt} toward your loan, homie."
  end

end
