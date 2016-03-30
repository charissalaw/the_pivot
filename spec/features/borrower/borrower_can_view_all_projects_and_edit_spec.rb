require "rails_helper"

RSpec.feature "BorrowerCanViewAllProjectsAndEdit", type: :feature do
  scenario "they can edit projects" do
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

    visit "/"
    click_on "login"

    fill_in "email", with: user.email
    fill_in "password", with: user.password

    within "div.sign-up-div" do
      click_on "login"
    end

    expect(current_path).to eq(borrower_user_path(user))

    click_on "active projects"

    expect(current_path).to eq(borrower_user_projects_path(user))

    within "div##{project.id}-project" do
      fill_in "name", with: "New Name"
      fill_in "description", with: "newly guud"
      select "new category", from: "project-category"
      select "nicaragua", from: "country-list"
      fill_in "goal", with: 1200
    end

    click_on "update project"

    expect(page).to have_content("Congrats! New Name has been updated!")

    expect(current_path).to eq(borrower_user_projects_path(user))
  end
end
