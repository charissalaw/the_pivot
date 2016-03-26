require "rails_helper"

RSpec.feature "UserAddsProjectToCart", type: :feature do
  scenario "user adds project to cart" do
    category = Category.create(name:"coffee")
    project = category.projects.create(name:"Ethiopian", goal:1500, description:"Ethiopian coffee is super good" )

    visit "/projects/#{project.id}"

    click_on "Add to cart"

    expect(page).to have_content("Ethiopian added to cart")
    expect(current_path).to eq("/projects")

    project2 = category.projects.create(name:"Columbian", goal:1800, description:"Columbian coffee is super good")

    visit "/projects/#{project2.id}"

    click_on "Add to cart"

    expect(page).to have_content("Columbian added to cart")
    expect(current_path).to eq("/projects")

    click_on "cart"

    expect(current_path).to eq("/cart")

    expect(page).to have_content(project.name)
    expect(page).to have_content(project.goal/100)
    expect(page).to have_content("$33")
  end
end
