require 'rails_helper'

RSpec.feature "GuestCanCreateLenderAccountAndLogout" do
  scenario "guest can register with lender account and logout" do
    register_and_login_user
    logout_user
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Sad to see you go Mister. Come back again soon.")
  end

  scenario "lender can login" do
    register_and_login_user
    logout_user
    expect(current_path).to eq(root_path)
    login_user
    expect(page).to have_content("Hey Mister, welcome to Lending Owl.")
  end
end
