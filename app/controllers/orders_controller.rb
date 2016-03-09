class OrdersController < ApplicationController
  helper OrdersHelper

  def new
    @products = OrderProcessor.new(@cart).products
    @order = Order.new
  end


  def checkout_user
    login_or_create_user
    redirect_to new_user_order_path(current_user)
  end

  def create
    order_processor = OrderProcessor.new(@cart)
    @order = order_processor.process_current_user(stripe_params, current_user)
    if @order.save
      @order.process(order_processor.products)
      UserMailer.order_email(@order).deliver
      flash[:info] = "Thanks for your order! :)"
      session[:cart] = nil
      redirect_to user_thanks_path(current_user, @order.id)
    else
      flash.now[:alert] = "Sorry, friend.  Something went wrong :(... Please try again."
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def thanks
    @order = Order.find(params[:order_id])
  end

  def index
    if current_user
      @orders = current_user.orders
    else
      redirect_to "public/404"
    end
  end

  def login_or_create_user
    @user = User.find_by(email: params[:email])
    @user = User.new(user_params) if @user.nil?
    if @user.save
      current_user
      session[:user_id] = @user.id
    else
      flash.now[:alert] = "Sorry, friend.  Something went wrong :(... Please try again."
      render :checkout_login
    end
  end

  def checkout_login

  end
  private

  def user_params
    params.permit(:fullname, :email, :password)
  end

  def stripe_params
    params.permit(:stripeEmail, :stripeToken, :stripeShippingName, :stripeShippingAddressLine1, :stripeShippingAddressCity, :stripeShippingAddressZip, :stripeShippingAddressState, :stripeShippingAddressZip )
  end

end
