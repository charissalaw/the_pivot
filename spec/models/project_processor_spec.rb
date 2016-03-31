require 'rails_helper'

RSpec.describe Project, :type => :model do
  before :each do
    create(:borrower_role)
    create(:lender_role)
    borrower_user = create(:user, fullname: "borrower jones", email: "borrow@email.com")
    borrower_user.roles << Role.find_by(name:"borrower")
    borrower = create(:borrower)
    borrower.update(user_id: borrower_user.id)
    category1 = create(:category)
    country1 = create(:country)
    @project_active1 = create(:project, goal: 500, borrower_id: borrower.id, category_id: category1.id, country_id: country1.id)
    lender_user = create(:user, fullname: "lender smith", email: "lender@email.com")
    order = lender_user.orders.create
    order.loans.create(quantity: 30000, project_id: @project_active1.id)
    order.loans.create(quantity: 18000, project_id: @project_active1.id)
  end


  scenario "they cant get more money once funded" do
    @project_active1.check_status
    expect(@project_active1.status).to eq("active")

    lender_user = create(:user, fullname: "lender new", email: "lendernew@email.com")
    order = lender_user.orders.create
    order.loans.create(quantity: 5000, project_id: @project_active1.id)
    @project_active1.check_status
    expect(@project_active1.status).to eq("funded")
  end

  scenario "the repayment status changes once debt is paid" do
    @project_active1.check_repayment_status
    expect(@project_active1.status).to eq("active")

    @project_active1.loans.sum(:quantity)
    @project_active1.repayments.create(project_id: @project_active1.id, amount_paid: 480)
    @project_active1.check_repayment_status
    expect(@project_active1.status).to eq("repaid")
    @project_active1.loans.each do |loan|
      expect(loan.status).to eq("paid")
    end
  end


end
