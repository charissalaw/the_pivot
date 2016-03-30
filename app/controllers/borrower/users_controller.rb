class Borrower::UsersController < ApplicationController
  def new
  end

  def index
  end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      borrower = BorrowerApplication.new(borrower_params).evaluate_borrower
      if borrower.save
        @user.roles << Role.find_by(name: "borrower")
        @user.borrower = borrower
        session[:user_id]= @user.id
        flash[:info] = "You have successfully created a borrower account... SWEET!"
        redirect_to borrower_user_path(current_user)
      else
        flash[:alert] = "Your credentials do not meet our requirements for a loan"
        redirect_to root_path
      end
    else
      flash[:info] = "Looks like you may already be a user! Please login."
      redirect_to login_path
    end
  end

  private

    def user_params
      params.permit(
        :fullname,
        :email,
        :password,
        :image
      )
    end

    def borrower_params
      params.permit(
        :annual_income,
        :monthly_housing,
        :monthly_credit_pmt,
        :dependents
      )
    end
end
