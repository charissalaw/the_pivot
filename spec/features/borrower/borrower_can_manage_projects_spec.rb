require "rails_helper"

RSpec.feature "BorrowerCanManageProjects", type: :feature do
  scenario "they can add projects" do
    create(:lender_role)
    create(:borrower_role)
    user = create(:user)
    borrower = create(:borrower)
    borrower.update(user_id: user.id)
    user.roles << Role.find_by(name:"borrower")
    create(:category)
    create(:country)

    visit "/"

    click_on "login"

    fill_in "email", with: user.email
    fill_in "password", with: user.password

    within "div.sign-up-div" do
      click_on "login"
    end

    expect(current_path).to eq(borrower_user_path(user))

    click_on "add project"

    expect(current_path).to eq(new_borrower_user_project_path(user))

    within "div#new-project" do
    fill_in "project title", with: "Ethiopian"
    fill_in "project goal", with: 100
    fill_in "description", with: "is guud"
    select "United States", from: "country-list"
    expect(page).to have_content("project image")
    select "education", from: "project-category"
    end
    click_on "create project"

    expect(page).to have_content("Your project has been created")
  end

  scenario "they can update projects" do
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

    visit "/"

    click_on "login"

    fill_in "email", with: user.email
    fill_in "password", with: user.password

    within "div.sign-up-div" do
      click_on "login"
    end

    visit project_path(project.slug)
    fill_in "project title", with: "New"
    fill_in "project goal", with: "5000"
    fill_in "description", with: "desc"
    select "nicaragua", from: "country-list"
    select "new category", from: "project-category"

    click_on "update project"

    expect(page).to have_content("Congrats! New has been updated!")
  end

  scenario "they can update projects sad path" do
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

    visit "/"

    click_on "login"

    fill_in "email", with: user.email
    fill_in "password", with: user.password

    within "div.sign-up-div" do
      click_on "login"
    end

    visit project_path(project.slug)
    fill_in "project title", with: ""
    fill_in "project goal", with: "5000"
    fill_in "description", with: "desc"
    select "nicaragua", from: "country-list"
    select "new category", from: "project-category"

    click_on "update project"

    expect(page).to have_content("Sorry, boss lolololololololol. Something went wrong :(... Please try again.")
  end
end
