require 'rails_helper'

RSpec.feature "RegisteredBorrowerCanLoginAndLogout" do

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

  scenario "registered borrower can log out" do
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
    logout_user
    expect(current_path).to eq(root_path)
  end

end
