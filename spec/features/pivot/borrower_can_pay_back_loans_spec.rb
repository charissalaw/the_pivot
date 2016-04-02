require "rails_helper"

RSpec.feature "BorrowerPaysLoans", type: :feature do
  scenario "they have option to pay back a portion of funding" do
    create(:lender_role)
    create(:borrower_role)
    borrower_user = create(:user, fullname: "borrower jones", email: "borrow@email.com")
    lender_user = create(:user, fullname: "lender smith", email: "lender@email.com")
    borrower_user.roles << Role.find_by(name:"borrower")
    borrower = create(:borrower)
    borrower.update(user_id: borrower_user.id)
    category1 = create(:category)
    category2 = create(:category, name: "space!")
    country1 = create(:country)
    country2 = create(:country, name: "nicaragua")
    project_active1 = create(:project, goal: 50000, borrower_id: borrower.id, category_id: category1.id, country_id: country1.id)
    order = lender_user.orders.create
    order.loans.create(quantity: 2500, project_id: project_active1.id)
    order.loans.create(quantity: 4000, project_id: project_active1.id)

    visit root_path
    click_on "login"
    within("div#login-form") do
      fill_in "email", with: borrower_user.email
      fill_in "password", with: borrower_user.password
      click_on "login"
    end

    click_on "active loans"
    expect(current_path).to eq(borrower_user_loans_path(borrower_user))
    click_on "pay back"

    expect(page).to have_content("repayment toward project #{project_active1.name}")
    expect(page).to have_content("Remaining amount: $65.0")
    select "30", from: "amount_paid"

    project_active1.repayments.create(project_id: project_active1.id, amount_paid: 30)
    visit borrower_user_loans_path(borrower_user)
    expect(page).to_not have_content("No loans yet!")

    within "##{project_active1.id}-project-detail" do
      expect(page).to have_content("Left to Pay: $35.0")
    end
  end
end
