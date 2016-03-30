require "rails_helper"

RSpec.feature "UserCantLeaveSignupFieldBlank", type: :feature do
  scenario "user gets error message" do
    visit new_user_path

    #do not fill in name field
    fill_in "email", with: "fakeymadeupthingymabob@fakeymadeupthingymabob"
    fill_in "password", with: "password"
    click_on "signup"

    expect(page).to have_content("Sorry, you can't leave any fields blank.")
  end
end
