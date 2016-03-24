require 'rails_helper'

RSpec.describe "General Permissions" do
  @user = User.new

  scenario "home#index" do
    permission = Permission.new(@user, 'home', 'index')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "mailing_list_emails#create" do
    permission = Permission.new(@user, 'mailing_list_emails', 'create')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "users#new" do
    permission = Permission.new(@user, 'users', 'new')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "users#create" do
    permission = Permission.new(@user, 'users', 'create')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "users#show" do
    permission = Permission.new(@user, 'users', 'show')
    result = permission.allow?
    expect(result).to be_falsey
  end

  scenario "borrower/users#new" do
    permission = Permission.new(@user, 'borrower/users', 'new')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "borrower/users#create" do
    permission = Permission.new(@user, 'borrower/users', 'create')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "borrower/users#show" do
    permission = Permission.new(@user, 'borrower/users', 'show')
    result = permission.allow?
    expect(result).to be_falsey
  end

  scenario "sessions#new" do
    permission = Permission.new(@user, 'sessions', 'new')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "sessions#create" do
    permission = Permission.new(@user, 'sessions', 'create')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "sessions#destroy" do
    permission = Permission.new(@user, 'sessions', 'destroy')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "projects#index" do
    permission = Permission.new(@user, 'projects', 'index')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "projects#show" do
    permission = Permission.new(@user, 'projects', 'show')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "order#checkout_user" do
    permission = Permission.new(@user, 'orders', 'checkout_user')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "order#checkout_login" do
    permission = Permission.new(@user, 'orders', 'checkout_login')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "order#new" do
    permission = Permission.new(@user, 'orders', 'new')
    result = permission.allow?
    expect(result).to be_falsey
  end

  scenario "order#create" do
    permission = Permission.new(@user, 'orders', 'create')
    result = permission.allow?
    expect(result).to be_falsey
  end

  scenario "order#index" do
    permission = Permission.new(@user, 'orders', 'index')
    result = permission.allow?
    expect(result).to be_falsey
  end

  scenario "order#show" do
    permission = Permission.new(@user, 'orders', 'show')
    result = permission.allow?
    expect(result).to be_falsey
  end

  scenario "order#thanks" do
    permission = Permission.new(@user, 'orders', 'thanks')
    result = permission.allow?
    expect(result).to be_falsey
  end

  scenario "categories#show" do
    permission = Permission.new(@user, 'categories', 'show')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "carts#show" do
    permission = Permission.new(@user, 'carts', 'show')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "cart_projects#create" do
    permission = Permission.new(@user, 'cart_projects', 'create')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "cart_projects#destroy" do
    permission = Permission.new(@user, 'cart_projects', 'destroy')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "cart_projects#update" do
    permission = Permission.new(@user, 'cart_projects', 'update')
    result = permission.allow?
    expect(result).to be true
  end
end
