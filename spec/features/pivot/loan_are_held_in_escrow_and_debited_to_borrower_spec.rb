require "rails_helper"

RSpec.feature "Loans are sent to escrow after creation", type: :feature do
  scenario "loan amounts are held in escrow and lending owl is in debted to project" do
    create(:lender_role)
    create(:borrower_role)
    borrower_user = create(:user, fullname: "borrower jones", email: "borrow@email.com")
    lender_user = create(:user, fullname: "lender smith", email: "lender@email.com")
    borrower_user.roles << Role.find_by(name:"borrower")
    borrower = create(:borrower)
    borrower.update(user_id: borrower_user.id)
    category1 = create(:category)
    country1 = create(:country)
    project_active1 = create(:project, borrower_id: borrower.id, category_id: category1.id, country_id: country1.id)
    order = lender_user.orders.create
    loan1 = order.loans.create(quantity: 25, project_id: project_active1.id)
    loan2 = order.loans.create(quantity: 30, project_id: project_active1.id)
    order.send_to_escrow

    expect(Escrow.first.project_id).to eq project_active1.id
    expect(Escrow.first.debt_amount).to eq 55
  end
end
