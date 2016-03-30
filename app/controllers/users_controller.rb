class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def update
    if current_user.update(user_params)
      flash[:info] = "Thanks #{current_user.first_name}! Your info has been updated."
      redirect_to current_user.dashboard
    else
      flash.now[:alert] = "Looks like that email already has an account..."
      render :show
    end
  end

  def show
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:info] = "Hey #{@user.first_name}, welcome to Lending Owl."
      redirect_to root_path
    elsif user_params[:name].nil? || user_params[:email].nil? || user_params[:password].nil?
      flash.now[:info] = "Sorry, you can't leave any fields blank."
      render :new
    else
      flash[:info] = "Hey, looks like your email is already registered. Please login."
      redirect_to login_path
    end
  end

private

  def user_params
    params.require(:user).permit(:fullname, :email, :password)
  end
end
