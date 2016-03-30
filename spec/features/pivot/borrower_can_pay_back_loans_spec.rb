require "rails_helper"

RSpec.feature "BorrowerPaysLoans", type: :feature do
  scenario "they have option to pay back a portion of loan" do
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
    project_active1 = create(:project, borrower_id: borrower.id, category_id: category1.id, country_id: country1.id)
    order = lender_user.orders.create
    order.loans.create(quantity: 2500, project_id: project_active1.id)

    visit root_path
    click_on "login"
    within("div#login-form") do
      fill_in "email", with: borrower_user.email
      fill_in "password", with: borrower_user.password
      click_on "login"
    end

    click_on "active loans"
    expect(page).to have_content("#{project_active1.name}")

    click_on "pay back"
    expect(current_path).to eq(new_project_repayment_path(project_active1.slug))

    expect(page).to have_content("repayment toward project #{project_active1.name}")

    select "5", from: "amount_paid"
  end
end
