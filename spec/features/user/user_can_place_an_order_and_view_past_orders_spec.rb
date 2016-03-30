require "rails_helper"

RSpec.feature "UserCanPlaceOrderAndViewPreviousOrder", type: :feature do
  scenario "user places order and views previous orders" do
    create(:lender_role)
    create(:borrower_role)
    borrower_user = create(:user, fullname: "borrower jones", email: "borrow@email.com")
    borrower_user.roles << Role.find_by(name:"borrower")
    borrower = create(:borrower)
    borrower.update(user_id: borrower_user.id)
    category = create(:category)
    country = create(:country)
    project = create(:project, borrower_id: borrower.id, category_id: category.id, country_id: country.id, goal:40)
    user = create(:user)
    order = user.orders.create
    loan = order.loans.create(project_id: project.id, quantity:2000)

    visit "/#{project.slug}"
    click_on "Loan"

    visit "/"

    click_on "login"

    within("div#login-form") do
      fill_in "email", with: user.email
      fill_in "password", with: user.password

      click_on "login"
    end

    click_on "cart"

    click_on "Confirm Loan"

    visit user_orders_path(user)

    expect(current_path).to eq("/users/#{user.id}/orders")

    expect(page).to have_content("#{project.name}")
  end
end
