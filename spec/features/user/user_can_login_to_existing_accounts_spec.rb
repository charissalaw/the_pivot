require "rails_helper"

RSpec.feature "UserCanLoginToExistingAccount", type: :feature do
  scenario "user logs in to account" do
    create(:lender_role)
    user0 = create(:user)

    visit "/"
    expect(page).to have_link("login")

    click_on "login"

    fill_in "email", with: user0.email
    fill_in "password", with: user0.password

    within "div.sign-up-div" do
      click_on "login"
    end
    expect(page).to have_content("Hey #{user0.first_name}, welcome to Lending Owl.")
  end

end
