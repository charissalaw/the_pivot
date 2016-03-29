require "rails_helper"

RSpec.feature "Platform admin can view and search all borrowers", type: :feature do
  scenario "they see appropriate borrowers" do
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
    project_active1 = create(:project, borrower_id: borrower1.id, category_id: category1.id, country_id: country1.id)
    project_active2 = create(:project, name: "rockets", borrower_id: borrower2.id, category_id: category2.id, country_id: country2.id)
    project_active3 = create(:project, name: "monsters", borrower_id: borrower3.id, category_id: category1.id, country_id: country1.id)


    visit "/"
    click_on "login"

    fill_in "email", with: admin.email
    fill_in "password", with: admin.password

    within "div.sign-up-div" do
      click_on "login"
    end

    expect(current_path).to eq(admin_user_path(admin))

    click_on "borrowers"

    within "tr##{user1.id}-borrower" do
      expect(page).to have_link(user1.fullname)
      expect(page).to have_content(user1.balance)
      expect(page).to have_content(user1.projects.count)
    end

    within "tr##{user2.id}-borrower" do
      expect(page).to have_link(user2.fullname)
    end

    within "tr##{user3.id}-borrower" do
      expect(page).to have_link(user3.fullname)
    end

    select:"space!", from: "category-search"
    click_on "filter by category"

    within "tr##{user2.id}-borrower" do
      expect(page).to have_link(user2.fullname)
      expect(page).to have_content(user2.balance)
      expect(page).to have_content(user2.projects.count)
    end

    expect(page).to_not have_content(user1.fullname)
    expect(page).to_not have_content(user3.fullname)

    select:"nicaragua", from:"country-search"
    click_on "filter by country"

    within "tr##{user2.id}-borrower" do
      expect(page).to have_link(user2.fullname)
      expect(page).to have_content(user2.balance)
      expect(page).to have_content(user2.projects.count)
    end

    expect(page).to_not have_content(user1.fullname)
    expect(page).to_not have_content(user3.fullname)


    expect(page).to_not have_content(user1.fullname)
    expect(page).to_not have_content(user3.fullname)

    fill_in "search by name", with: "smy"
    click_on "search by name"

    within "tr##{user3.id}-borrower" do
      expect(page).to have_link(user3.fullname)
      expect(page).to have_content(user3.balance)
      expect(page).to have_content(user3.projects.count)
    end

    expect(page).to_not have_content(user1.fullname)
    expect(page).to_not have_content(user2.fullname)

    fill_in "search by borrower id", with: -1
    click_on "search by id"

    expect(page).to have_content("Borrower -1 doesn't exist!")


    fill_in "search by borrower id", with: user2.id
    click_on "search by id"

    expect(current_path).to eq(admin_borrower_path(user2))
  end
end
