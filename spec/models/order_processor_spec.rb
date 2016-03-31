require 'rails_helper'

RSpec.describe OrderProcessor, :type => :model do
  before :each do
    create(:lender_role)
    create(:borrower_role)
    borrower_user = create(:user, fullname: "borrower jones", email: "borrow@email.com")
    @lender_user = create(:user, fullname: "lender smith", email: "lender@email.com")
    borrower_user.roles << Role.find_by(name:"borrower")
    borrower = create(:borrower)
    borrower.update(user_id: borrower_user.id)
    category1 = create(:category)
    country1 = create(:country)
    project_active1 = create(:project, borrower_id: borrower.id, category_id: category1.id, country_id: country1.id)
    @cart = Cart.new({"#{project_active1.id}"=>5})
  end

  scenario "it processes orders" do
    @order_processor = OrderProcessor.new({card_token: "token"}, @cart, @lender_user)

    expect(@order_processor.order.card_token).to eq("token")
    expect(@order_processor.order.user_id).to eq(2)
    expect(@order_processor.order.id).to eq(1)
    expect(@order_processor.order.order_total).to eq(500)
    expect(@order_processor.order.status).to eq("escrow")
  end
end
