require 'rails_helper'

RSpec.feature "UserRemovesAProjectFromCarts", type: :feature do
  scenario "they see all that the removed item is no longer there" do

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
    click_on "Loan"

    expect(page).to have_link("loans ($10)")

    click_on "loans ($10)"

    expect(page).to have_content(project_active1.name)
    expect(page).to have_content(project_active2.name)

    click_link("remove from cart", :match => :first)

    expect(page).to have_link("loans ($5)")

    expect(page).to_not have_link("loans ($10)")
  end
end
