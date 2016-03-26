require "rails_helper"

RSpec.feature "UserViewsProjectsByCategory", type: :feature do
  scenario "user views projects by category" do
    category = Category.create(name:"coffee")

    project = category.projects.create(name: "Ethiopian", goal: 1500, description: "Ethiopian coffee is super good")

    visit root_path

    click_on "coffee"

    within "div##{project.id}-category-project" do
      expect(page).to have_content(project.name)
      expect(page).to have_link "#{project.id}-project-image"
      expect(page).to have_link "#{project.id}-project"
    end
  end
end
