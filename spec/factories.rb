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

  factory :admin_user, parent: :user do
    fullname "Admin Admin"
    email "admin@gmail.com"
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
    goal 1000
  end

  factory :loan do
    quantity Faker::Number.number(2)
  end

  factory :borrower_attribute do
    category "income"
    label "$20,000 to $30,000"
    score 7
  end

  factory :housing_costs, parent: :borrower_attribute do
    category "housing"
    label "< $500"
    score 4
  end

  factory :credit_costs, parent: :borrower_attribute do
    category "credit"
    label "< $500"
    score 1
  end

  factory :dependents, parent: :borrower_attribute do
    category "dependents"
    label "0"
    score 5
  end

  factory :fail_borrower_attribute, parent: :borrower_attribute do
    category "income"
    label "> $60,000"
    score 7
  end

  factory :fail_housing_costs, parent: :borrower_attribute do
    category "housing"
    label "> $5000"
    score 10
  end

  factory :fail_credit_costs, parent: :borrower_attribute do
    category "credit"
    label "> $5000"
    score 10
  end

  factory :fail_dependents, parent: :borrower_attribute do
    category "dependents"
    label "10"
    score 10
  end

end
