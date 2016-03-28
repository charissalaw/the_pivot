require "rails_helper"

RSpec.feature "LenderSignsIn", type: :feature do
  scenario "lender creates borrow account which pulls lender data" do
    create(:borrower_attribute)
    create(:housing_costs)
    create(:credit_costs)
    create(:dependents)
    create(:lender_role)
    user = create(:user)
    login_created_user(user)
    visit root_path
    create(:borrower_role)
    click_on "become a borrower"

    within("div#signup") do
      select "$20,000 to $30,000", from: "borrower_annual_income"
      select "< $500", from: "borrower_monthly_housing"
      select "< $500", from: "borrower_monthly_credit_pmt"
      select "0", from: "borrower_dependents"

      click_on "Apply"
    end
    expect(page).to have_content("You have successfully created a borrower account... SWEET!")
    expect(current_path).to eq(borrower_user_path(user))

  end

end
