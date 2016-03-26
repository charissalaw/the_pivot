require "rails_helper"

RSpec.feature "BorrowerCanManageProjects", type: :feature do
  scenario "they see the correct flash message after project is added" do
    create(:lender_role)
    create(:borrower_role)
    user = create(:user)
    borrower = create(:borrower)
    borrower.update(user_id: user.id)
    user.roles << Role.find_by(name:"borrower")
    create(:category)
    create(:country)

    visit "/"

    click_on "login"

    fill_in "email", with: user.email
    fill_in "password", with: user.password

    within "div.sign-up-div" do
      click_on "login"
    end

    visit borrower_user_path(user)

    click_on "add project"

    expect(current_path).to eq(new_borrower_project_path)

    within "div#new-project" do
    fill_in "project title", with: "Ethiopian"
    fill_in "project goal", with: 100
    fill_in "description", with: "is guud"
    select "United States", from: "country-list"
    expect(page).to have_content("project image")
    select "education", from: "project-category"
    end
    click_on "create project"

    expect(page).to have_content("Your project has been created")
  end
end
