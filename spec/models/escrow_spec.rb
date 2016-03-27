require 'rails_helper'

RSpec.describe Escrow, type: :model do
  it { should validate_presence_of :project_id }
end
