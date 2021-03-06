require 'rails_helper'

RSpec.feature "Visitor visits lend path" do
  scenario "they see the page showing all projects" do
    country = Country.create(name: "Kenya")
    category = Category.create(name: "education")
    create(:lender_role)
    create(:borrower_role)
    create(:user)
    borrower = create(:borrower)

    Project.create(name:        "Project Name",
                   country_id:  country.id,
                   description: "Description",
                   category_id: category.id,
                   goal:       1500,
                   image:       open("https://s3.amazonaws.com/littleowl-turing/products/Aeropress.png"),
                   borrower_id: borrower.id,
                   )

    visit root_path
    click_on "lend"
    expect(current_path).to eq(lend_path)
    expect(page).to have_content("Project Name")
    expect(page).to have_content("$1500")
    expect(page).to have_content("education")
    expect(page).to have_content("Kenya")
    expect(page).to have_xpath("//img")
  end
end
