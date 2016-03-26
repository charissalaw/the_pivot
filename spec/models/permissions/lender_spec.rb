require 'rails_helper'

RSpec.describe "Lender Permissions" do
  before(:each) do
    create(:lender_role)
    @lender = create(:user)
  end

  scenario "home#index" do
    permission = Permission.new(@lender, 'home', 'index')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "mailing_list_emails#create" do
    permission = Permission.new(@lender, 'mailing_list_emails', 'create')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "users#new" do
    permission = Permission.new(@lender, 'users', 'new')
    result = permission.allow?
    expect(result).to be_falsey
  end

  scenario "users#create" do
    permission = Permission.new(@lender, 'users', 'create')
    result = permission.allow?
    expect(result).to be_falsey
  end

  scenario "users#show" do
    permission = Permission.new(@lender, 'users', 'show')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "borrowers#new" do
    permission = Permission.new(@lender, 'borrowers', 'new')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "borrowers#create" do
    permission = Permission.new(@lender, 'borrowers', 'create')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "borrower/users#show" do
    permission = Permission.new(@lender, 'borrower/users', 'show')
    result = permission.allow?
    expect(result).to be_falsey
  end

  scenario "sessions#new" do
    permission = Permission.new(@lender, 'sessions', 'new')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "sessions#create" do
    permission = Permission.new(@lender, 'sessions', 'create')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "sessions#destroy" do
    permission = Permission.new(@lender, 'sessions', 'destroy')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "projects#index" do
    permission = Permission.new(@lender, 'projects', 'index')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "projects#show" do
    permission = Permission.new(@lender, 'projects', 'show')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "order#checkout_user" do
    permission = Permission.new(@lender, 'orders', 'checkout_user')
    result = permission.allow?
    expect(result).to be_falsey
  end

  scenario "order#checkout_login" do
    permission = Permission.new(@lender, 'orders', 'checkout_login')
    result = permission.allow?
    expect(result).to be_falsey
  end

  scenario "order#new" do
    permission = Permission.new(@lender, 'orders', 'new')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "order#create" do
    permission = Permission.new(@lender, 'orders', 'create')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "order#index" do
    permission = Permission.new(@lender, 'orders', 'index')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "order#show" do
    permission = Permission.new(@lender, 'orders', 'show')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "order#thanks" do
    permission = Permission.new(@lender, 'orders', 'thanks')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "categories#show" do
    permission = Permission.new(@lender, 'categories', 'show')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "carts#show" do
    permission = Permission.new(@lender, 'carts', 'show')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "cart_projects#create" do
    permission = Permission.new(@lender, 'cart_projects', 'create')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "cart_projects#destroy" do
    permission = Permission.new(@lender, 'cart_projects', 'destroy')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "cart_projects#update" do
    permission = Permission.new(@lender, 'cart_projects', 'update')
    result = permission.allow?
    expect(result).to be true
  end
end
