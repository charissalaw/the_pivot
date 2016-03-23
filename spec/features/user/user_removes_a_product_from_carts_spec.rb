require 'rails_helper'

RSpec.feature "UserRemovesAProjectFromCarts", type: :feature do
  scenario "they see all that the removed item is no longer there" do
    category = Category.create(name:"coffee")
    project = category.projects.create(name:"Ethiopian", price:1500, description:"Ethiopian coffee is super good")

    project2 = category.projects.create(name:"Columbian", price:1800, description:"Columbian coffee is super good")
    visit "/projects/#{project.id}"
    click_on "Add to cart"

    visit "/projects/#{project2.id}"
    click_on "Add to cart"

    visit cart_path

    within("div##{project.id}-project") do
      click_on "remove from cart"
    end

    expect(current_path).to eq(cart_path)

    expect(page).to have_content("You have removed #{project.name} from your cart.")

    expect(page).to_not have_content(project.description)
    expect(page).to_not have_content(project.price/100)

    expect(page).to have_link "#{project.name}"
    expect(page).to have_content("$18")
  end
end
