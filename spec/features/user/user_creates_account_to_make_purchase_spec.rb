require "rails_helper"

RSpec.feature "UserCreatesAccount", type: :feature do
  scenario "user creates account" do
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

    click_on "loans"

    click_on "Confirm Loan"
    fill_in "name", with: "john"
    fill_in "email", with: "john@john"
    fill_in "enter or create password", with: "password"
    click_on "continue"

    expect(page).to have_content("Hey, john.")

    expect(page).to have_content(project.name)

    expect(current_path).to eq(new_user_order_path(User.last))
  end
end
