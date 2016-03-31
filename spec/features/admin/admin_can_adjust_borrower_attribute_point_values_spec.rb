require "rails_helper"

RSpec.feature "AdminCanAdjustBorrowerAttributes", type: :feature do
  scenario "they are able to adjust borrower attributes" do
    create(:lender_role)
    create(:borrower_role)
    create(:admin_role)
    admin = create(:admin_user)
    Role.all.each do |role|
      admin.roles << role
    end
    generate_borrower_attributes

    visit "/"
    click_on "login"

    fill_in "email", with: admin.email
    fill_in "password", with: admin.password

    within "div.sign-up-div" do
      click_on "login"
    end

    click_on "borrower attributes"

    expect(current_path).to eq(admin_borrower_attributes_path)
    expect(BorrowerAttribute.find(1).score).to eq(7)

    within "tr#1-income" do
      select "20", from: "score"
      fill_in "label", with: "testing"
      click_on "score"
    end

    expect(BorrowerAttribute.find(1).score).to eq(20)
    expect(BorrowerAttribute.find(1).label).to eq("testing")
    expect(page).to have_content("Attribute Updated. Please review carefully!")
    expect(BorrowerAttribute.find(2).score).to eq(7)


    within "tr#2-housing" do
      select "20", from: "score"
      click_on "score"
    end

    expect(BorrowerAttribute.find(2).score).to eq(20)
    expect(page).to have_content("Attribute Updated. Please review carefully!")
    expect(BorrowerAttribute.find(3).score).to eq(7)

    within "tr#3-credit-payment" do
      select "20", from: "score"
      fill_in "label", with: "testing"
      click_on "score"
    end

    expect(page).to have_content("Attribute Updated. Please review carefully!")
    expect(BorrowerAttribute.find(3).score).to eq(20)
    expect(BorrowerAttribute.find(3).label).to eq("testing")
    expect(BorrowerAttribute.find(4).score).to eq(1)

    within "tr#4-dependent" do
      select "20", from: "score"
      fill_in "label", with: "testing"
      click_on "score"
    end

    expect(BorrowerAttribute.find(4).score).to eq(20)
    expect(BorrowerAttribute.find(4).label).to eq("testing")
    expect(page).to have_content("Attribute Updated. Please review carefully!")
  end
end
