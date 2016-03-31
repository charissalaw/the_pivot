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

  scenario "user signsup to existing account" do
    create(:lender_role)
    user0 = create(:user)

    visit "/"
    click_on "login"
    click_on "signup"

    fill_in "name", with: user0.fullname
    fill_in "email", with: user0.email
    fill_in "password", with: user0.password
    click_on "signup"

    expect(page).to have_content("Hey, looks like your email is already registered. Please login.")
  end

  scenario "user edits existing account with invalid email" do
    create(:lender_role)
    user0 = create(:user)
    user1 = create(:user, email:"test@test.com")

    visit "/"
    expect(page).to have_link("login")

    click_on "login"

    fill_in "email", with: user0.email
    fill_in "password", with: user0.password

    within "div.sign-up-div" do
      click_on "login"
    end

    click_on user0.fullname.downcase

    fill_in "email", with: user1.email
    click_on "update"
    
    expect(page).to have_content("Looks like that email already has an account...")
  end
end
