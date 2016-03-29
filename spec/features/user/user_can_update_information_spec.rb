require "rails_helper"

RSpec.feature "UsersCanUpdateInformation", type: :feature do
  scenario "they can add update information" do
    create(:lender_role)
    create(:borrower_role)
    create(:admin_role)
    admin = create(:admin_user)
    Role.all.each do |role|
      admin.roles << role
    end
    borrower_user = create(:borrower_user)
    borrower = create(:borrower)
    borrower.update(user_id: borrower_user.id)
    borrower_user.roles << Role.find_by(name:"borrower")
    user = create(:user)

    visit "/"

    click_on "login"

    fill_in "email", with: admin.email
    fill_in "password", with: admin.password

    within "div.sign-up-div" do
      click_on "login"
    end

    within "li.dropdown" do
      click_on "admin"
    end

    fill_in "name", with: "New Name"
    click_on "update"

    expect(page).to have_content("New")
    expect(current_path).to eq(admin_user_path(admin))
    click_on "logout"

    click_on "login"

    fill_in "email", with: borrower_user.email
    fill_in "password", with: borrower_user.password

    within "div.sign-up-div" do
      click_on "login"
    end

    within "li.dropdown" do
      click_on "borrower"
    end

    fill_in "name", with: "New Name"
    click_on "update"

    expect(page).to have_content("New")
    expect(current_path).to eq(borrower_user_path(borrower_user))
    click_on "logout"

    click_on "login"

    fill_in "email", with: user.email
    fill_in "password", with: user.password

    within "div.sign-up-div" do
      click_on "login"
    end

    within "li.dropdown" do
      click_on "jane"
    end

    fill_in "name", with: "New Name"
    click_on "update"

    expect(page).to have_content("New")
    expect(current_path).to eq("/")
  end
end
