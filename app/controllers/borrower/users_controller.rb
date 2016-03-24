class Borrower::UsersController < ApplicationController
  def new
  end

  def show
  end

  def create
    if current_user.blank?
      @user = User.new(user_params)
    end
    if @user.save
      borrower = Borrower.new(borrower_params)
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
      flash.now[:alert] = "You are missing something"
      render :new
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
        :description,
        :annual_income,
        :monthly_housing,
        :monthly_credit_pmt,
        :dependents
      )
    end
end
