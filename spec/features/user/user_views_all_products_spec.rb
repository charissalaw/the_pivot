require "rails_helper"

RSpec.feature "UserViewsAllProjects", type: :feature do
  scenario "user views all projects" do
    category = Category.create(name:"coffee")
    project = category.projects.create(name:"Ethiopian", price:1500, description:"Ethiopian coffee is super good")

    visit projects_path

    within "div##{project.id}-index" do
      expect(page).to have_content(project.name)
    end
  end
end
