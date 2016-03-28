require "rails_helper"

RSpec.feature "NonUserCanMakeALoan", type: :feature do
  scenario "non-user makes a loan" do
    create(:lender_role)
    create(:borrower_role)
    borrower_user = create(:user, fullname: "borrower jones", email: "borrow@email.com")
    borrower_user.roles << Role.find_by(name:"borrower")
    borrower = create(:borrower)
    borrower.update(user_id: borrower_user.id)
    category1 = create(:category)
    country1 = create(:country)
    project_active1 = create(:project, borrower_id: borrower.id, category_id: category1.id, country_id: country1.id)

    visit project_path(project_active1)

    select "$25", from: "loan-amount"
    click_on "Loan"

    click_on "cart"

    select "$105", from: "loan-amount"
    click_on "Update"
    click_on "Confirm Loan"

    expect(current_path).to eq("/loans/login")

    fill_in "fullname", with: "John Adams"
    fill_in "email", with: "test@test.com"
    fill_in "password", with: "password"


    click_on "continue"
    
    expect(page).to have_content("Some of your loans have been adjusted.  Please review.")
    expect(page).to have_content("$100")
    expect(page).to have_content("submit loans")
  end
end
