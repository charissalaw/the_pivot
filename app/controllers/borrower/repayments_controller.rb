class Borrower::RepaymentsController < ApplicationController

  def update
    repayment = Repayment.find(params[:id])
    new_amount = repayment.amount_paid + params[:amount].to_i
    repayment.update(amount_paid: new_amount)
    redirect_to borrower_user_loans_path(current_user)
    flash[:info] = "You have paid $#{new_amount} toward your loan, homie."
  end

  def show
    @repayment = Repayment.find(params[:id])
    @project = Project.find(@repayment.project_id)
  end

end
