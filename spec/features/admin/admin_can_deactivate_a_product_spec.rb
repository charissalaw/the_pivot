require "rails_helper"

RSpec.feature "AdminCanDeactivateAProject", type: :feature do
  scenario "they are able to deactivate an item" do
    admin = User.create(fullname: "john adams",
                        email: "admin@example.com",
                        password: "password",
                        role: 1)

    category = Category.create(name: "coffee")
    project = category.projects.create(name: "Ethiopian",
                                       price:1500,
                                       description: "Ethiopian coffee is super good",
                                      )

    visit "/"
    click_on "login"
    fill_in "email", with: admin.email
    fill_in "password", with: admin.password

    click_on "login"

    visit admin_dashboard_path

    click_on "active projects"

    expect(current_path).to eq(admin_projects_path)

    within "tr##{project.id}-project" do
      find(:css, "#project_inactive").set(true)
      click_on "update project"
    end

    expect(page).to have_content("Ethiopian has been deactivated")

    click_on "inactive projects"

    expect(current_path).to eq(admin_projects_path)

    within "tr##{project.id}-project" do
      click_on "update project"
    end

    expect(page).to have_content("Sorry mate! Reactivate the project!")

    within "tr##{project.id}-project" do
      find(:css, "#project_inactive").set(false)
      click_on "update project"
    end

    expect(page).to have_content("Ethiopian has been activated")
  end
end
