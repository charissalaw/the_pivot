require "rails_helper"

RSpec.feature "BorrowerCanViewDashboard", type: :feature do
  scenario "they can see totals of money asked for" do
    create(:lender_role)
    create(:borrower_role)
    user = create(:user)
    borrower = create(:borrower)
    borrower.update(user_id: user.id)
    user.roles << Role.find_by(name:"borrower")
    category = create(:category)
    create(:category, name: "new category")
    country = create(:country)
    create(:country, name: "nicaragua")
    project = create(:project, borrower_id: borrower.id, category_id: category.id, country_id: country.id)
    project2 = create(:project, name: "project2", borrower_id: borrower.id, category_id: category.id, country_id: country.id)
    order = user.orders.create
    loan1 = order.loans.create(quantity: 2500, project_id: project.id)
    loan2 = order.loans.create(quantity: 3000, project_id: project.id)
    loan3 = order.loans.create(quantity: 3500, project_id: project2.id)

    visit "/"
    click_on "login"

    fill_in "email", with: user.email
    fill_in "password", with: user.password

    within "div.sign-up-div" do
      click_on "login"
    end

    expect(current_path).to eq(borrower_user_path(user))

    click_on "dashboard"

    expect(current_path).to eq(borrower_user_path(user))

    expect(page).to have_content("project goals")

    expect(page).to have_content("repayment toward")
    expect(page).to have_content("#{project.name}")
    expect(page).to have_content("#{project2.name}")
  end
end
