require 'rails_helper'

RSpec.describe Order, :type => :model do
  it { should validate_presence_of :user_id}

  it { should belong_to :user }
  it { should have_many :loans }
  it { should have_many :projects }

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
    @order_processor = OrderProcessor.new({card_token: "token"}, @cart, @lender_user)
  end

  scenario "it displays total" do
    order = @order_processor.order
    expect(order.display_total).to eq("$500")
  end

  scenario "it displays loan count" do
    order = @order_processor.order
    expect(order.project_quantity).to eq(1)
  end

  scenario "it displays name" do
    order = @order_processor.order
    expect(order.name).to eq("lender smith")
  end
end
