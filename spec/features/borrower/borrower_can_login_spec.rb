require "rails_helper"

RSpec.feature "BorrowerCanLoginToExistingAccount", type: :feature do
  scenario "user logs in to account" do
    create(:lender_role)
    create(:borrower_role)
    user0 = create(:user)
    borrower0 = create(:borrower)
    user0.roles << Role.find_by(name:"borrower")

    visit "/"
    expect(page).to have_link("login")

    click_on "login"

    fill_in "email", with: user0.email
    fill_in "password", with: user0.password

    within "div.sign-up-div" do
      click_on "login"
    end
    expect(current_path).to eq("/borrower/users/#{user0.id}")
    expect(page).to have_content("Hey #{user0.first_name.downcase}")
  end

end
