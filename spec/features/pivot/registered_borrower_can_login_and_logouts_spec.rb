require 'rails_helper'

RSpec.feature "RegisteredBorrowerCanLoginAndLogouts" do

  scenario "registered borrower can log in" do
    user = create(:user)
    borrower = create(:borrower)
    borrower.user_id = user.id
    user.update(role: 1)
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

end
