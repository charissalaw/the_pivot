require "rails_helper"

RSpec.feature "UnregisteredUserSignsUpAsBorrower", type: :feature do
  scenario "unqualified borrower gets error message" do
    visit "/"

    click_on "borrow"
    expect(current_path).to eq(new_borrower_user_path)
    # I expect to be on the 'borrowers/users/new' path
    # I see options to log in or register.
    within("div#signup") do
      fill_in "name", with: "test name"
      fill_in "email", with: "email@email.com"
      fill_in "password", with: "password"
      fill_in "description", with: "some description"
      # select "$50,000+",from: "annual_income"
      fill_in "annual income", with: "6000000"
      fill_in "monthly_housing", with: "500"
      fill_in "monthly_credit_pmt", with: "300"
      # select "4",from: "dependent_quantity"
      fill_in "dependents", with: "5"
      expect(page).to have_content("Add Image")
      click_on "Apply"
    end

    # When I click on the option to register,
    expect(current_path).to eq("/")
    expect(page).to have_content("Your credentials do not meet our requirements for a loan")
  end

  scenario "unqualified borrower gets approved" do
    visit "/"

    click_on "borrow"
    expect(current_path).to eq(new_borrower_user_path)
    # I expect to be on the 'borrowers/users/new' path
    # I see options to log in or register.
    within("div#signup") do
      fill_in "name", with: "test name"
      fill_in "email", with: "email@email.com"
      fill_in "password", with: "password"
      fill_in "description", with: "some description"
      # select "$50,000+",from: "annual_income"
      fill_in "annual income", with: "600000"
      fill_in "monthly_housing", with: "500"
      fill_in "monthly_credit_pmt", with: "300"
      # select "4",from: "dependent_quantity"
      fill_in "dependents", with: "5"
      expect(page).to have_content("Add Image")
      click_on "Apply"
    end

    # When I click on the option to register,
    current_user = User.last
    expect(current_path).to eq(borrower_user_path(current_user))
    expect(page).to have_content("You have successfully created a borrower account... SWEET!")
  end
end
