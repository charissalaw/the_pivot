require 'rails_helper'

RSpec.describe "Borrower Permissions" do
  before(:each) do
    create(:lender_role)
    create(:borrower_role)
    @borrower = create(:user)
    @borrower.roles << Role.find_by(name: "borrower")
  end

  scenario "home#index" do
    permission = Permission.new(@borrower, 'home', 'index')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "mailing_list_emails#create" do
    permission = Permission.new(@borrower, 'mailing_list_emails', 'create')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "users#new" do
    permission = Permission.new(@borrower, 'users', 'new')
    result = permission.allow?
    expect(result).to be_falsey
  end

  scenario "users#create" do
    permission = Permission.new(@borrower, 'users', 'create')
    result = permission.allow?
    expect(result).to be_falsey
  end

  scenario "users#show" do
    permission = Permission.new(@borrower, 'users', 'show')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "borrower/users#new" do
    permission = Permission.new(@borrower, 'borrower/users', 'new')
    result = permission.allow?
    expect(result).to be_falsey
  end

  scenario "borrower/users#create" do
    permission = Permission.new(@borrower, 'borrower/users', 'create')
    result = permission.allow?
    expect(result).to be_falsey
  end

  scenario "borrower/users#show" do
    permission = Permission.new(@borrower, 'borrower/users', 'show')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "sessions#new" do
    permission = Permission.new(@borrower, 'sessions', 'new')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "sessions#create" do
    permission = Permission.new(@borrower, 'sessions', 'create')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "sessions#destroy" do
    permission = Permission.new(@borrower, 'sessions', 'destroy')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "projects#index" do
    permission = Permission.new(@borrower, 'projects', 'index')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "projects#show" do
    permission = Permission.new(@borrower, 'projects', 'show')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "order#checkout_user" do
    permission = Permission.new(@borrower, 'orders', 'checkout_user')
    result = permission.allow?
    expect(result).to be_falsey
  end

  scenario "order#checkout_login" do
    permission = Permission.new(@borrower, 'orders', 'checkout_login')
    result = permission.allow?
    expect(result).to be_falsey
  end

  scenario "order#new" do
    permission = Permission.new(@borrower, 'orders', 'new')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "order#create" do
    permission = Permission.new(@borrower, 'orders', 'create')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "order#index" do
    permission = Permission.new(@borrower, 'orders', 'index')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "order#show" do
    permission = Permission.new(@borrower, 'orders', 'show')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "order#thanks" do
    permission = Permission.new(@borrower, 'orders', 'thanks')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "categories#show" do
    permission = Permission.new(@borrower, 'categories', 'show')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "cart#show" do
    permission = Permission.new(@borrower, 'cart', 'show')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "cart_projects#create" do
    permission = Permission.new(@borrower, 'cart_projects', 'create')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "cart_projects#destroy" do
    permission = Permission.new(@borrower, 'cart_projects', 'destroy')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "cart_projects#update" do
    permission = Permission.new(@borrower, 'cart_projects', 'update')
    result = permission.allow?
    expect(result).to be true
  end
end
