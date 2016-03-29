require "rails_helper"

RSpec.feature "UserCanLoginAndReviewLoanHistory", type: :feature do
  scenario "user logs in to account" do
    create(:lender_role)
    create(:borrower_role)
    borrower_user = create(:user, fullname: "borrower jones", email: "borrow@email.com")
    borrower_user.roles << Role.find_by(name:"borrower")
    borrower = create(:borrower)
    borrower.update(user_id: borrower_user.id)
    category1 = create(:category)
    country1 = create(:country)
    project = create(:project, borrower_id: borrower.id, category_id: category1.id, country_id: country1.id, goal:40)

    user = create(:user)
    order = user.orders.create
    loan = order.loans.create(project_id: project.id, quantity:2000)

    visit "/"

    click_on "login"

    within("div#login-form") do
      fill_in "email", with: user.email
      fill_in "password", with: user.password

      click_on "login"
    end

    expect(page).to have_content("Hey #{user.first_name}, welcome to Lending Owl.")

    expect(current_path).to eq("/")

    expect(page).to_not have_link("login")
    expect(page).to have_link("logout")
    expect(page).to have_link("loan history")

    click_on "loan history"
    expect(page).to have_content(project.name)
    expect(page).to have_content(loan.display_total)
    expect(page).to have_content(loan.date)
    expect(page).to have_content(project.id)
  end
end
