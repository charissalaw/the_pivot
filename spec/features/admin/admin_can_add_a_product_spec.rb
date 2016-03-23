require "rails_helper"

RSpec.feature "AdminCanAddProject", type: :feature do
  scenario "they see the correct flash message after project is added" do
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
    select "coffee", from: "project-category"
    end
    click_on "create project"

    expect(page).to have_content("Life is good, john")
  end
end
