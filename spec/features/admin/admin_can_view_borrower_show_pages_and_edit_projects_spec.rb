require "rails_helper"

RSpec.feature "AdminCanManageProjects", type: :feature do
  scenario "they can add  and edit projects" do
    create(:lender_role)
    create(:borrower_role)
    create(:admin_role)
    admin = create(:admin_user)
    Role.all.each do |role|
      admin.roles << role
    end
    user1 = create(:user)
    borrower1 = create(:borrower)
    borrower1.update(user_id: user1.id)
    user1.roles << Role.find_by(name:"borrower")
    create(:category)
    create(:country)

    visit "/"

    click_on "login"

    fill_in "email", with: admin.email
    fill_in "password", with: admin.password

    within "div.sign-up-div" do
      click_on "login"
    end

    click_on 'borrowers'
    click_on user1.fullname
    expect(current_path).to eq(admin_borrower_path(borrower1.id))

    within "div#new-project" do
      fill_in "project title", with: "Ethiopian"
      fill_in "project goal in dollars", with: 100
      fill_in "description", with: "is guud"
      select "United States", from: "country-list"
      expect(page).to have_content("project image")
      select "education", from: "project-category"
    end

    click_on "create project"

    expect(page).to have_content("A project has been created for #{user1.fullname}")
    expect(page).to have_content("Ethiopian")

    within "div.project-header" do
      fill_in "project goal in dollars", with: 400
    end
    click_on "update project"

    expect(page).to have_content("Project #{Project.last.name} has been updated.")
  end
end
