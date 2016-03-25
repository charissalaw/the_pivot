require 'rails_helper'

RSpec.describe Loan, :type => :model do
  it { should validate_presence_of :quantity }
  it { should validate_presence_of :project_id }
  it { should validate_presence_of :order_id }
  it { should belong_to :order }
  it { should belong_to :project }
end
