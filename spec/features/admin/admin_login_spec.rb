require "rails_helper"

RSpec.feature "AdminCanLoginToDashboard", type: :feature do
  scenario "user logs in to account" do
    create(:lender_role)
    create(:borrower_role)
    create(:admin_role)
    admin = create(:admin_user)
    Role.all.each do |role|
      admin.roles << role
    end

    visit "/"
    expect(page).to have_link("login")

    click_on "login"

    fill_in "email", with: admin.email
    fill_in "password", with: admin.password

    within "div.sign-up-div" do
      click_on "login"
    end
    expect(current_path).to eq("/admin/users/#{admin.id}")
    expect(page).to have_content("Hey #{admin.first_name.downcase}")
  end
end
