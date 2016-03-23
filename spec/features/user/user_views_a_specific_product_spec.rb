require "rails_helper"

RSpec.feature "UserViewsASpecificProject", type: :feature do
  scenario "user views a specific project" do
    category = Category.create(name:"coffee")
    project = category.projects.create(name:"Ethiopian", price:1500, description:"Ethiopian coffee is super good")

    visit "/coffee"

    within "div##{project.name}-link" do
      click_on "#{project.id}-project"
    end

    expect(current_path).to eq("/projects/#{project.id}")

    within "div#project" do
      expect(page).to have_content(project.name)
      expect(page).to have_content(project.description)
    end
  end
end
