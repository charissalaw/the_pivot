require "rails_helper"

RSpec.feature "BorrowerCanViewDashboard", type: :feature do
  scenario "they can see totals of money asked for" do
    create(:lender_role)
    create(:borrower_role)
    user = create(:user)
    borrower = create(:borrower)
    borrower.update(user_id: user.id)
    user.roles << Role.find_by(name:"borrower")
    category = create(:category)
    create(:category, name: "new category")
    country = create(:country)
    create(:country, name: "nicaragua")
    project = create(:project, borrower_id: borrower.id, category_id: category.id, country_id: country.id)
    project2 = create(:project, name: "project2", borrower_id: borrower.id, category_id: category.id, country_id: country.id)

    visit "/"
    click_on "login"

    fill_in "email", with: user.email
    fill_in "password", with: user.password

    within "div.sign-up-div" do
      click_on "login"
    end

    expect(current_path).to eq(borrower_user_path(user))

    click_on "dashboard"

    expect(current_path).to eq(borrower_user_path(user))

    expect(page).to have_content("Here are your stats")

    expect(page).to have_content("$$ asked for")
  end
end
