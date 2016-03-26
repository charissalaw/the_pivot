FactoryGirl.define do

  factory :role do
    name "lender"
  end

  factory :lender_role, parent: :role do
    name "lender"
  end

  factory :borrower_role, parent: :role do
    name "borrower"
  end

  factory :admin_role, parent: :role do
    name "admin"
  end

  factory :borrower do
    username            "username"
    annual_income       20000
    monthly_housing     1000
    monthly_credit_pmt  500
    dependents          4
  end

  factory :user do
    fullname "Jane Doe"
    email    "jane@gmail.com"
    password "password"
  end

  factory :category do
    name "education"
  end

  factory :country do
    name "United States"
  end

  factory :project do
    name "factory project"
    description Faker::Lorem.paragraph
    goal 100
  end

end
