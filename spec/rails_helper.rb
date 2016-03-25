# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is projection
abort("The Rails environment is running in projection mode!") if Rails.env.projection?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rails'
require 'support/database_cleaner'
require 'factory_girl_rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec

    with.library :rails
  end
end

def register_and_login_user
  create(:lender_role)
  visit root_path
  click_on "login"
  click_on "signup"
  within("div#signup-form") do
    fill_in "name", with: "Mister Bojangles"
    fill_in "email", with: "bojangles@example.com"
    fill_in "password", with: "password"
    click_on "signup"
  end
end

def logout_user
  click_on "logout"
end

def login_user
  click_on "login"
  within("div#login-form") do
    fill_in "email", with: "bojangles@example.com"
    fill_in "password", with: "password"
    click_on "login"
  end
end

def login_created_user(user)
  visit root_path
  click_on "login"
  within("div#login-form") do
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_on "login"
  end
end

def create_borrower_account(user)
  visit root_path
  create(:borrower_role)
  # user.Roles << Role.find_by(name:"borrower")
  click_on "become a borrower"
  within("div#signup") do
    fill_in "description", with: "some description"
    fill_in "annual income", with: "600000"
    fill_in "monthly_housing", with: "500"
    fill_in "monthly_credit_pmt", with: "300"
    fill_in "dependents", with: "5"
    expect(page).to have_content("Add Image")
    click_on "Apply"
  end
end
