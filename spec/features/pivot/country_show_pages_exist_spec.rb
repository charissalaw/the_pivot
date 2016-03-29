require 'rails_helper'

RSpec.feature "user sees country show page" do
  scenario "country details page" do
    country = create(:country)

    visit "/country/#{country.slug}"

    expect(page).to have_content("#{country.name}")
  end

  scenario "user sees projects based in given country" do
    create(:lender_role)
    create(:borrower_role)
    borrower_user = create(:user, fullname: "borrower jones", email: "borrow@email.com")
    lender_user = create(:user, fullname: "lender smith", email: "lender@email.com")
    borrower_user.roles << Role.find_by(name:"borrower")
    borrower = create(:borrower)
    borrower.update(user_id: borrower_user.id)
    category1 = create(:category)
    country1 = create(:country)
    project1 = create(:project, borrower_id: borrower.id, category_id: category1.id, country_id: country1.id)
    project2 = create(:project, name: "As I Lay Dying", borrower_id: borrower.id, category_id: category1.id, country_id: country1.id)

    visit "/country/#{country1.slug}"

    expect(page).to have_content("#{country1.name}")
    expect(page).to have_content("#{project1.name}")
    expect(page).to have_content("#{project2.name}")
save_and_open_page
  end
end
