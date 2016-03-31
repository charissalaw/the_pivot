require "rails_helper"

RSpec.feature "AdminCanAdjustBorrowerAttributes", type: :feature do
  scenario "they are able to adjust borrower attributes" do
    create(:lender_role)
    create(:borrower_role)
    create(:admin_role)
    admin = create(:admin_user)
    Role.all.each do |role|
      admin.roles << role
    end
    generate_borrower_attributes

    visit "/"
    click_on "login"

    fill_in "email", with: admin.email
    fill_in "password", with: admin.password

    within "div.sign-up-div" do
      click_on "login"
    end

    click_on "borrower attributes"

    expect(current_path).to eq(admin_borrower_attributes_path)

    within "tr#1-income" do
      select "20", from: "score"
      click_on "score"
    end

    expect(page).to have_content("Attribute Updated. Please review carefully!")

    within "tr#2-housing" do
      select "20", from: "score"
      click_on "score"
    end

    expect(page).to have_content("Attribute Updated. Please review carefully!")

    within "tr#3-credit-payment" do
      select "20", from: "score"
      click_on "score"
    end

    expect(page).to have_content("Attribute Updated. Please review carefully!")

    within "tr#4-dependent" do
      select "20", from: "score"
      click_on "score"
    end

    expect(page).to have_content("Attribute Updated. Please review carefully!")
    save_and_open_page
  end
end
