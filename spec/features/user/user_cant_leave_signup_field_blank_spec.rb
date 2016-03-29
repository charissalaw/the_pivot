require "rails_helper"

RSpec.feature "UserCantLeaveSignupFieldBlank", type: :feature do
  scenario "user gets error message" do

    create(:lender_role)
    user0 = create(:user)

    visit "/"

    click_on "login"
    click_on "signup"

    expect(current_path).to eq("/users/new")
    fill_in "email", with: "test@test.com"
    fill_in "password", with: "password"

    click_on "signup"

    expect(page).to have_content("Sorry, friend. Something went wrong :(... Please try again.")
  end
end
