require 'rails_helper'

RSpec.feature "UnregisteredUsersPermissions" do

  scenario "unregistered visits root_path and joins mailing list" do
    visit root_path
    expect(current_path).to eq(root_path)
    expect(status_code).to eq(200)

    fill_in "email", with: "test@example.com"
    click_on "sign up"

    expect(current_path).to eq(root_path)
    expect(page).to_not have_content("Can't go there:(")
  end
end
