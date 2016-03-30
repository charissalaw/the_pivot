require "rails_helper"

RSpec.feature "UserViewsProjectsByCategory", type: :feature do
  scenario "user views projects by category" do
    create(:lender_role)
    create(:borrower_role)
    borrower_user = create(:user, fullname: "borrower jones", email: "borrow@email.com")
    lender_user = create(:user, fullname: "lender smith", email: "lender@email.com")
    borrower_user.roles << Role.find_by(name:"borrower")
    borrower = create(:borrower)
    borrower.update(user_id: borrower_user.id)
    category1 = create(:category, slug: "education")
    country1 = create(:country)
    project = create(:project, borrower_id: borrower.id, category_id: category1.id, country_id: country1.id)

    visit category_path(category1.slug)

    expect(page).to have_content(project.name)
    expect(page).to have_link "#{project.id}-project-image"
    expect(page).to have_link "#{project.id}-project"
  end
end
