class Admin::UsersController < ApplicationController

  def show
    @orders = Order.all
    @loans = Loan.all
    flash.now[:info] = current_user.admin_message.sample
  end
end
