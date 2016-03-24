require 'rails_helper'

RSpec.feature "Visitor visits lend path" do
  scenario "they see all borrowers" do
    create(:lender_role)
    create(:borrower_role)
    user = create(:user)
    borrower = create(:borrower)
    borrower.user_id = user.id
    user.roles << Role.find_by(name:"borrower")
    # As a visitor
    # When I visit the home page
    visit root_path
    # And I click on 'Lend'
    click_on "lend"
  # I expect to be on the '/lend' path
    expect(current_path).to eq(lend_path)
  # I can see all borrowers that I can lend to
    expect(page).to have_content("Choose a Borrower")
  # I see an image, where they are from, the percent funded and how much funding they still need
  end
end
