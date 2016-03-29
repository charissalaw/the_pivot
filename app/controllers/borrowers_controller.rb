class BorrowersController < ApplicationController

  def new
  end

  def create
    borrower = BorrowerApplication.new(borrower_params).evaluate_borrower
    if borrower.save
      current_user.roles << Role.find_by(name: "borrower")
      current_user.borrower = borrower
      flash[:info] = "You have successfully created a borrower account... SWEET!"
      redirect_to borrower_user_path(current_user)
    else
      flash[:alert] = "Your credentials do not meet our requirements for a loan"
      redirect_to root_path
    end
  end

  private

  def borrower_params
    params.require(:borrower).permit(
      :description,
      :annual_income,
      :monthly_housing,
      :monthly_credit_pmt,
      :dependents,
    )
  end

end
