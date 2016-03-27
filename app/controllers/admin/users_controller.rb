class Admin::UsersController < Admin::BaseController

  def show
    @orders = Order.all
    @loans = Loan.all
    flash.now[:info] = current_user.admin_message.sample
  end
end
