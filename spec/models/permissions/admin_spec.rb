require 'rails_helper'

RSpec.describe "Admin Permissions" do
  before(:each) do
    create(:lender_role)
    @admin = create(:user)
    create(:admin_role)
    @admin.roles << Role.find_by(name: "admin")
  end

  scenario "home#index" do
    permission = Permission.new(@admin, 'home', 'index')
    result = permission.allow?
    expect(result).to be true
  end
end
