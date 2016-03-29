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
    project_active2 = create(:project, name: "rockets", borrower_id: borrower.id, category_id: category2.id, country_id: country2.id)
    order = lender_user.orders.create
    loan1 = order.loans.create(quantity: 25, project_id: project_active1.id)
    loan2 = order.loans.create(quantity: 30, project_id: project_active1.id)
    loan3 = order.loans.create(quantity: 35, project_id: project_active2.id)
    repayment = create(:repayment, project_id: project_active1.id, amount_paid: "100")

    visit root_path
    click_on "login"
    within("div#login-form") do
      fill_in "email", with: borrower_user.email
      fill_in "password", with: borrower_user.password
      click_on "login"
    end

    click_on "active loans"
    expect(page).to have_content("#{project_active1.name}")
    expect(page).to have_content("#{project_active2.name}")

    within "tr##{project_active1.id}-project" do
      click_on "pay back"
      expect(current_path).to eq(borrower_user_repayment_path(borrower_user, repayment))
    end

    expect(page).to have_content("repayment toward project #{project_active1.name}")

    select "5", from: "amount"
    click_on "pay now"

    expect(current_path).to eq(borrower_user_loans_path(borrower))
    save_and_open_page
    expect(page).to have_content("You have paid $105 toward your loan, homie.")

    within "tr##{project_active1.id}-project" do
      save_and_open_page
      expect(page).to have_content("105")
    end

  end

end
