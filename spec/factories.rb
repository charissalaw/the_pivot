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
    description         "this is gonna be huge"
    annual_income       2000000
    monthly_housing     1000000
    monthly_credit_pmt  500
    dependents          4
  end

  factory :user do
    fullname "Jane Doe"
    email    "jane@gmail.com"
    password "password"
  end

end
