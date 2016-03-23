class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart
  before_action :authorize!
  helper_method :current_user

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize!
    unless authorized?
      flash[:alert] = "Can't go there:("
      redirect_to root_path
    end
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def current_borrower?
    current_user && current_user.borrower?
  end

private
  def authorized?
    current_permission.allow?
  end

  def current_permission
    @current_permission ||= Permission.new(current_user, params[:controller], params[:action])
  end
end
