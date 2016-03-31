require "rails_helper"

RSpec.feature "User searches projects", type: :feature do
  before :each do
    create(:lender_role)
    create(:borrower_role)
    user = create(:user)
    borrower = create(:borrower)
    borrower.update(user_id: user.id)
    user.roles << Role.find_by(name:"borrower")
    category = create(:category)
    country = create(:country)
    create(:country, name: "nicaragua")
    project = create(:project, goal: 20000, borrower_id: borrower.id, category_id: category.id, country_id: country.id)
    project2 = create(:project, name: "project2", goal: 25000, borrower_id: borrower.id, category_id: category.id, country_id: country.id)
    order = user.orders.create
    order.loans.create(quantity: 2500, project_id: project.id)
    order.loans.create(quantity: 3000, project_id: project.id)
    order.loans.create(quantity: 3500, project_id: project2.id)
  end

  scenario "user searches by country" do
    visit "/"
    select "United States", from: "country-search"
    click_on "search by country"
    expect(page).to have_content("factory project")
  end

  scenario "user searches by country" do
    visit "/"
    select "education", from: "category-search"
    click_on "search by category"
    expect(page).to have_content("factory project")
  end
end
