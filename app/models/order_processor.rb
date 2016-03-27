class OrderProcessor
  attr_reader :projects

  def initialize(cart)
    @cart = cart
    @projects = cart.projects
  end

  def adjust_loans
    @cart.adjust_loans
  end

  def process_current_user(params, current_user)
    processed_params = process_user_params(params)
    current_user.orders.new(processed_params)
  end

  def cart_total
      @projects.map do |project|
      project.goal * project.quantity
    end.reduce(:+) / 100
  end

  def process_user_params(params)
    {
      email: params[:stripeEmail],
      fullname: params[:stripeShippingName],
      street: params[:stripeShippingAddressLine1],
      city: params[:stripeShippingAddressCity],
      state: params[:stripeShippingAddressState],
      zip: params[:stripeShippingAddressZip],
      card_token: params[:stripeToken]}
  end
end
