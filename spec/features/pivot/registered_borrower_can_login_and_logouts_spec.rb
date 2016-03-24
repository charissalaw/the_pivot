require 'rails_helper'

RSpec.feature "RegisteredBorrowerCanLoginAndLogouts" do

  scenario "registered borrower can log in" do
    create(:lender_role)
    create(:borrower_role)
    user = create(:user)
    borrower = create(:borrower)
    borrower.user_id = user.id
    user.roles << Role.find_by(name:"borrower")
    visit root_path
    click_on "login"
    expect(current_path).to eq(login_path)
    within("div#login-form") do
      fill_in "email", with: "jane@gmail.com"
      fill_in "password", with: "password"
      click_on "login"
    end
    expect(current_path).to eq(borrower_user_path(user))
  end

  scenario "guest can register with lender account and logout" do
    create_user
    logout_user
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Sad to see you go Mister. Come back again soon.")
  end

  scenario "lender can login" do
    create_user
    logout_user
    expect(current_path).to eq(root_path)
    login_user
    expect(page).to have_content("Hey Mister, welcome to Lending Owl.")
  end

end
