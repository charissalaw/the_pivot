require "rails_helper"

RSpec.feature "LenderSignsIn", type: :feature do
  scenario "lender creates borrow account which pulls lender data" do
    create(:lender_role)
    user = create(:user)
    login_created_user(user)
    visit root_path
    create(:borrower_role)
    click_on "become a borrower"
    expect(page).to have_selector("input[value='#{user.name}']")
    expect(page).to have_selector("input[value='#{user.email}']")
    within("div#signup") do
      fill_in "password", with: user.password
      fill_in "description", with: "some description"
      fill_in "annual income", with: "400000"
      fill_in "monthly_housing", with: "500"
      fill_in "monthly_credit_pmt", with: "300"
      fill_in "dependents", with: "5"
      expect(page).to have_content("Add Image")
      click_on "Apply"
    end
    expect(page).to have_content("You have successfully created a borrower account... SWEET!")
    expect(current_path).to eq(borrower_user_path(user))

  end

end
