require 'rails_helper'

RSpec.describe Borrower, type: :model do
  it { should validate_presence_of :username}
  it { should validate_presence_of :annual_income}
  it { should validate_presence_of :monthly_housing}
  it { should validate_presence_of :monthly_credit_pmt}
  it { should validate_presence_of :dependents}
  it { should validate_numericality_of(:annual_income).is_less_than(5_000_000) }
end
