require "rails_helper"

RSpec.feature "AdminCanSearchProjects", type: :feature do
  before :each do
    create(:lender_role)
    create(:borrower_role)
    create(:admin_role)
    @admin = create(:admin_user)
    Role.all.each do |role|
      @admin.roles << role
    end
    @user1 = create(:user)
    user2 = create(:user, fullname: "john smith", email: "john@smith")
    user3 = create(:user, fullname: "will smyth", email: "will@smyth")
    borrower1 = create(:borrower)
    borrower2 = create(:borrower)
    borrower3 = create(:borrower)
    borrower1.update(user_id: @user1.id)
    borrower2.update(user_id: user2.id)
    borrower3.update(user_id: user3.id)
    @user1.roles << Role.find_by(name:"borrower")
    user2.roles << Role.find_by(name:"borrower")
    user3.roles << Role.find_by(name:"borrower")
    category1 = create(:category)
    category2 = create(:category, name: "space!")
    country1 = create(:country)
    country2 = create(:country, name: "nicaragua")
    project1 = create(:project, borrower_id: borrower1.id, category_id: category1.id, country_id: country1.id)
    @project_active2 = create(:project, name: "rockets", borrower_id: borrower2.id, category_id: category2.id, country_id: country2.id)
    project_active3 = create(:project, name: "monsters", borrower_id: borrower3.id, category_id: category1.id, country_id: country1.id)

    visit "/"
    click_on "login"

    fill_in "email", with: @admin.email
    fill_in "password", with: @admin.password

    within "div.sign-up-div" do
      click_on "login"
    end

    expect(current_path).to eq(admin_user_path(@admin))
  end

  scenario "they can search by borrower id" do
    click_on "active projects"
    fill_in "id_search", with: @user1.id
    click_on "search by borrower id"
    expect(page).to have_content(@user1.name)
  end

  scenario "they can search by category" do
    click_on "active projects"
    select "space!", from: "category_search"
    click_on "filter by category"
    expect(page).to have_content(@project_active2.name)
  end

  scenario "they can search by country" do
    click_on "active projects"
    select "nicaragua", from: "country_search"
    click_on "filter by country"
    expect(page).to have_content(@project_active2.name)
  end
end
