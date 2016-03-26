require "rails_helper"

RSpec.feature "LenderSignsIn", type: :feature do
  scenario "lender creates borrow account which pulls lender data" do
    create(:lender_role)
    user = create(:user)
    login_created_user(user)
    visit root_path
    create(:borrower_role)
    click_on "become a borrower"
    within("div#signup") do
      fill_in "borrower username", with: "username"
      fill_in "annual income", with: "400000"
      fill_in "monthly mortgage or rent payment", with: "500"
      fill_in "monthly credit payment", with: "300"
      fill_in "number of dependents", with: "5"
      click_on "Apply"
    end
    expect(page).to have_content("You have successfully created a borrower account... SWEET!")
    expect(current_path).to eq(borrower_user_path(user))

  end

end
