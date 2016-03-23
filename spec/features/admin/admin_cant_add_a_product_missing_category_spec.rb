require "rails_helper"

RSpec.feature "AdminCantAddProjectWithoutCategory", type: :feature do
  scenario "they see the correct flash message when adding a project with a missing category" do
    admin = User.create(fullname: "john adams",
                        email: "admin@example.com",
                        password: 'password',
                        role: 1)

    Category.create(name: "coffee")
    visit "/"

    click_on "login"

    fill_in "email", with: admin.email
    fill_in "password", with: admin.password

    click_on "login"

    visit admin_dashboard_path

    click_on "add project"

    expect(current_path).to eq(new_admin_project_path)

    within "div#new-project" do
    fill_in "name", with: "Ethiopian"
    fill_in "price", with: 100
    fill_in "description", with: "is guud"
    click_on "create project"
    end

    expect(page).to have_content("Sorry, boss lolololololololol. Something went wrong :(... Please try again.")
  end
end
