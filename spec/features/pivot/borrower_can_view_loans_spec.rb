require "rails_helper"

RSpec.feature "BorrowerViewsAllLoans", type: :feature do
  scenario "they see all of the active loans for projects" do
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
    # borrower_user.borrower.loans => "all loans"

    visit root_path
    click_on "login"
    within("div#login-form") do
      fill_in "email", with: borrower_user.email
      fill_in "password", with: borrower_user.password
      click_on "login"
    end

    click_on "active loans"
    expect(current_path).to eq(borrower_user_loans_path(borrower_user))
    expect(page).to have_content(project_active1.name)
    expect(page).to have_content(project_active2.name)

  end

  scenario "they see all of the completed loans for projects" do
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
    loan1 = order.loans.create(quantity: 25, project_id: project_active1.id, status: "completed")
    loan2 = order.loans.create(quantity: 30, project_id: project_active1.id, status: "completed")
    loan3 = order.loans.create(quantity: 35, project_id: project_active2.id, status: "completed")

    visit root_path
    click_on "login"
    within("div#login-form") do
      fill_in "email", with: borrower_user.email
      fill_in "password", with: borrower_user.password
      click_on "login"
    end

    click_on "completed loans"
    expect(current_path).to eq(borrower_user_loans_path(borrower_user))
    expect(page).to have_content(project_active1.name)
    expect(page).to have_content(project_active2.name)
  end
end
