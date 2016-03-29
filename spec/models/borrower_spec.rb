require 'rails_helper'

RSpec.describe Borrower, type: :model do
  it { should validate_presence_of :annual_income}
  it { should validate_presence_of :monthly_housing}
  it { should validate_presence_of :monthly_credit_pmt}
  it { should validate_presence_of :dependents}
end
