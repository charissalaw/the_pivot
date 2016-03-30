require 'rails_helper'

RSpec.describe Repayment, type: :model do
  it { should validate_presence_of :project_id}
  it { should validate_presence_of :amount_paid}
end
