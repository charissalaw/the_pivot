require "rails_helper"

RSpec.feature "UnregisteredUserSignsUpAsBorrower", type: :feature do
  scenario "unqualified borrower gets error message" do
    create(:lender_role)
    create(:borrower_role)
    create(:fail_borrower_attribute)
    create(:fail_housing_costs)
    create(:fail_credit_costs)
    create(:fail_dependents)
    visit "/"

    click_on "borrow"
    expect(current_path).to eq(new_borrower_user_path)
    within("div#signup") do
      fill_in "name", with: "test name"
      fill_in "email", with: "email@email.com"
      fill_in "password", with: "password"
      select "> $60,000", from: "annual_income"
      select "> $5000", from: "monthly_housing"
      select "> $5000", from: "monthly_credit_pmt"
      select "10", from: "dependents"
      click_on "Apply"
    end

    expect(current_path).to eq("/")
    expect(page).to have_content("Your credentials do not meet our requirements for a loan")
  end

  scenario "qualified borrower gets approved" do
    create(:lender_role)
    create(:borrower_role)
    create(:borrower_attribute)
    create(:housing_costs)
    create(:credit_costs)
    create(:dependents)
    visit "/"

    click_on "borrow"
    expect(current_path).to eq(new_borrower_user_path)
    within("div#signup") do
      fill_in "name", with: "test name"
      fill_in "email", with: "email@email.com"
      fill_in "password", with: "password"
      select "$20,000 to $30,000", from: "annual_income"
      select "< $500", from: "monthly_housing"
      select "< $500", from: "monthly_credit_pmt"
      select "0", from: "dependents"
      click_on "Apply"
    end

    current_user = User.last
    expect(current_path).to eq(borrower_user_path(current_user))
    expect(page).to have_content("You have successfully created a borrower account... SWEET!")
  end
end
