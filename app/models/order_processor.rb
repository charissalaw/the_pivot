class OrderProcessor
  attr_reader :order

  def initialize(order_params, cart, current_user)
    @cart = cart
    @order = current_user.orders.new(order_params)
    process
  end

  def process
    if @order.save
      create_loans
      @order.update(order_total: @order.total)
      send_to_escrow
    end
  end

  def create_loans
    @cart.projects.each do |project|
      @order.loans.create(project_id: project.id, quantity: (@cart.contents[project.id.to_s] * 100))
    end
  end

  def send_to_escrow
    Escrow.send_to_escrow(@order)
  end
end
