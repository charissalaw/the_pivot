require 'rails_helper'

RSpec.describe Loan, :type => :model do
  it { should validate_presence_of :quantity }
  it { should validate_presence_of :project_id }
  it { should validate_presence_of :order_id }
  it { should belong_to :order }
  it { should belong_to :project }

  scenario "user views order thanks" do
    create(:lender_role)
    create(:borrower_role)
    create(:admin_role)
    admin = create(:admin_user)
    Role.all.each do |role|
      admin.roles << role
    end
    borrower_user = create(:user, fullname: "borrower jones", email: "borrow@email.com")
    lender_user = create(:user, fullname: "lender smith", email: "lender@email.com")
    borrower_user.roles << Role.find_by(name:"borrower")
    borrower = create(:borrower)
    borrower.update(user_id: borrower_user.id)
    category1 = create(:category)
    category2 = create(:category, name: "space!")
    country1 = create(:country)
    country2 = create(:country, name: "nicaragua")
    project_active1 = create(:project, borrower_id: borrower.id, category_id: category1.id, country_id: country1.id)
    project_active2 = create(:project, name: "rockets", borrower_id: borrower.id, category_id: category2.id, country_id: country2.id)
    order = lender_user.orders.create
    l1 = order.loans.create(quantity: 25, project_id: project_active1.id)
    l2 = order.loans.create(quantity: 300, project_id: project_active1.id)
    l3 = order.loans.create(quantity: 35, project_id: project_active2.id)

    expect(Loan.active_loans.pluck(:id)).to eq([l1.id, l2.id, l3.id])
    expect(Loan.paid.pluck(:id)).to eq([])
    expect(Loan.top_project.id).to eq(project_active1.id)
    expect(l1.date).to eq(l1.updated_at.strftime("%B %-d, %Y"))
    expect(l2.display_total).to eq("$3")
  end
end
