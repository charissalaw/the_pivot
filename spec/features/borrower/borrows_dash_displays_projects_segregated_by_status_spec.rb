require "rails_helper"

RSpec.feature "BorrowersDashShowProjects", type: :feature do
  scenario "they can active projects" do
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
    project_active = create(:project, borrower_id: borrower.id, category_id: category.id, country_id: country.id)
    project_inactive = create(:project, name: "whatever", borrower_id: borrower.id, category_id: category.id, country_id: country.id, inactive: true)

    visit "/"
    click_on "login"

    fill_in "email", with: user.email
    fill_in "password", with: user.password

    within "div.sign-up-div" do
      click_on "login"
    end
    
    click_on "active projects"

    expect(page).to have_selector("input[value = '#{project_active.name}']")
    expect(page).to_not have_selector("input[value = '#{project_inactive.name}']")

    click_on "funded projects"

    expect(page).to have_selector("input[value = '#{project_inactive.name}']")
    expect(page).to_not have_selector("input[value = '#{project_active.name}']")

  end
end
