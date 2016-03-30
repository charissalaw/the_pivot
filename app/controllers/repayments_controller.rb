class RepaymentsController < ApplicationController

  def update
    repayment = Repayment.find(params[:id])
    new_amount = repayment.amount_paid + params[:amount].to_i
    repayment.update(amount_paid: new_amount)
    redirect_to borrower_user_loans_path(current_user)
    flash[:info] = "You have paid $#{new_amount} toward your loan, homie."
  end

  def new
    @project = current_user.projects.find_by_slug(params[:project])
    @repayment = @project.repayments.new
  end

  def create
    project = current_user.projects.find_by_slug(project_params)
    @repayment = project.repayments.new(repayment_params)
    if @repayment.save
      @repayment.process_project
      flash[:info] = "Thanks for your payment! :)"
      redirect_to borrower_user_loans_path(current_user)
    else
      flash.now[:alert] = "Sorry, friend.  Something went wrong :(... Please try again."
      render :new
    end
  end

private
  def repayment_params
    params.permit(:amount_paid, :stripeToken)
  end

  def project_params
    params.permit(:project)[:project]
  end
end
