require "rails_helper"

RSpec.feature "projects have slugs", type: :feature do
  scenario "visiting slug url displays project show page" do
    create(:lender_role)
    create(:borrower_role)
    borrower_user = create(:user, fullname: "borrower jones", email: "borrow@email.com")
    lender_user = create(:user, fullname: "lender smith", email: "lender@email.com")
    borrower_user.roles << Role.find_by(name:"borrower")
    borrower = create(:borrower)
    borrower.update(user_id: borrower_user.id)
    category1 = create(:category)
    country1 = create(:country)
    project_active1 = create(:project, borrower_id: borrower.id, category_id: category1.id, country_id: country1.id)
    project_active2 = create(:project, name: "Invisible", borrower_id: borrower.id, category_id: category1.id, country_id: country1.id)
  
    visit "/#{project_active1.slug}"

    expect(page).to have_content(project_active1.name)
    expect(page).to_not have_content(project_active2.name)

  end
end
