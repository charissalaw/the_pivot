FactoryGirl.define do

  factory :borrower do
    description     "this is gonna be huge"
    annual_income   2000000
    monthly_housing 1000000
    monthly_credit_pmt  500
    dependents      4
  end

  factory :user do
    fullname "Jane Doe"
    email "jane@gmail.com"
    password "password"
  end

end
