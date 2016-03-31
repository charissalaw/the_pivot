require 'rails_helper'

RSpec.describe Repayment, type: :model do
  it { should validate_presence_of :project_id}
  it { should validate_presence_of :amount_paid}

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
    @project_active1 = create(:project, borrower_id: borrower.id, category_id: category1.id, country_id: country1.id)
  end

  scenario "it processes projects" do
    repayment = Repayment.create(project_id:@project_active1.id, amount_paid:500, stripeToken:"token")

    repayment.process_project
    expect(@project_active1.status).to eq("active")
  end
end
