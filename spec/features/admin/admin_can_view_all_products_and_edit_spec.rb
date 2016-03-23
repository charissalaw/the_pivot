require "rails_helper"

RSpec.feature "AdminCanViewAllItemsAndEdit", type: :feature do
  scenario "they edit items" do
    admin = User.create(first_name: "john",
                        last_name: "adams",
                        fullname: "john adams",
                        email: "admin@example.com",
                        password: "password",
                        role: 1)

    Category.create(name: "new category")
    category = Category.create(name: "coffee")
    project = category.projects.create(name: "Ethiopian",
                                       price: 1500,
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
      fill_in "name", with: "New Name"
      fill_in "description", with: "newly guud"
      select "new category", from: "project-category"
      find(:css, "#sale").set(true)
      fill_in "sale price", with: 1200
    end

    click_on "update project"

    expect(page).to have_content("Congrats! New Name has been updated!")

    expect(current_path).to eq(admin_projects_path)
  end
end
