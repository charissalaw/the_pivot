require 'rails_helper'

RSpec.feature "UserChangesProjectLoanAmountInCart", type: :feature do
  scenario "they change the project's loan amount and see it updated in the cart" do

    create(:lender_role)
    create(:borrower_role)
    borrower_user = create(:user, fullname: "borrower jones", email: "borrow@email.com")
    borrower_user.roles << Role.find_by(name:"borrower")
    borrower = create(:borrower)
    borrower.update(user_id: borrower_user.id)
    category1 = create(:category)
    country1 = create(:country)
    project_active1 = create(:project, borrower_id: borrower.id, category_id: category1.id, country_id: country1.id)
    project_active2 = create(:project, name: "second", borrower_id: borrower.id, category_id: category1.id, country_id: country1.id)

    visit "/lend"

    click_link(project_active1.name, :match => :first)

    expect(current_path).to eq("/#{project_active1.slug}")

    within "div#project" do
      expect(page).to have_content(project_active1.name)
      expect(page).to have_content(project_active1.description)
    end

    click_on "Loan"

    expect(page).to have_link("loans ($5)")

    click_link(project_active2.name, :match => :first)
    select:"$10", from:"loan-amount"
    click_on "Loan"

    expect(page).to have_link("loans ($15)")

    click_on "loans ($15)"

    expect(page).to have_content(project_active1.name)
    expect(page).to have_content(project_active2.name)
    expect(page).to have_content("Your loan: $5")

    within "h1.cart-total" do
      expect(page).to have_content("$15")
    end

    within "div##{project_active1.id}-project" do
      select:"$65", from: "loan-amount"
      click_on "Update"
    end

    expect(current_path).to eq(cart_path)
    expect(page).to have_content("$65")
    expect(page).to have_content("$10")

    within "h1.cart-total" do
      expect(page).to have_content("$75")
    end

    expect(page).to_not have_content("Your loan: $5")
  end
end
