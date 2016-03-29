require 'rails_helper'

RSpec.feature "dashboard links work" do
  scenario "each homepage link can be clicked and leads to valid page" do
    create(:category, name: "agriculture")
    create(:category, name: "food")
    create(:category, name: "education")

    visit "/"
    click_on "become a lender"
    expect(current_path).to eq "/lend"

    visit "/"
    click_on "become a borrower"
    expect(current_path).to eq "/borrower/users/new"

    visit "/"
    click_on "education"
    expect(current_path).to eq "/categories/education"

    visit "/"
    click_link "agriculture"
    expect(current_path).to eq "/categories/agriculture"

    visit "/"
    click_on "food"
    expect(current_path).to eq "/categories/food"
  end
end
