require "rails_helper"

RSpec.feature "AdminCantAddProjectWithoutCategory", type: :feature do
  scenario "they see the correct flash message when adding a project with a missing category" do
    create(:lender_role)
    create(:borrower_role)
    create(:admin_role)
    admin = create(:admin_user)
    Role.all.each do |role|
      admin.roles << role
    end
    user1 = create(:user)
    user2 = create(:user, fullname: "john smith", email: "john@smith")
    user3 = create(:user, fullname: "will smyth", email: "will@smyth")
    borrower1 = create(:borrower)
    borrower2 = create(:borrower)
    borrower3 = create(:borrower)
    borrower1.update(user_id: user1.id)
    borrower2.update(user_id: user2.id)
    borrower3.update(user_id: user3.id)
    user1.roles << Role.find_by(name:"borrower")
    user2.roles << Role.find_by(name:"borrower")
    user3.roles << Role.find_by(name:"borrower")
    category1 = create(:category)
    category2 = create(:category, name: "space!")
    country1 = create(:country)
    country2 = create(:country, name: "nicaragua")
    project1 = create(:project, borrower_id: borrower1.id, category_id: category1.id, country_id: country1.id)
    project_active2 = create(:project, name: "rockets", borrower_id: borrower2.id, category_id: category2.id, country_id: country2.id)
    project_active3 = create(:project, name: "monsters", borrower_id: borrower3.id, category_id: category1.id, country_id: country1.id)

    visit "/"
    expect(page).to have_link("login")

    click_on "login"

    fill_in "email", with: admin.email
    fill_in "password", with: admin.password

    within "div.sign-up-div" do
      click_on "login"
    end

    visit admin_borrower_path(user1.borrower.id)

    within "div#new-project" do
    fill_in "project title", with: "Glory Road"
    fill_in "description", with: "Heinlein's name is spelled weird"
    click_on "create project"
    end

    expect(page).to have_content("What have you done wrong?")
  end
end
