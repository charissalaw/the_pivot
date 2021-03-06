require 'rails_helper'

RSpec.describe Project, :type => :model do

  it { should validate_presence_of :name}
  it { should validate_presence_of :goal}
  it { should validate_presence_of :description}
  it { should validate_presence_of :category_id}
  it { should validate_presence_of :country_id}
  it { should validate_presence_of :borrower_id}
  it { should have_attached_file(:image) }
  it { should validate_attachment_content_type(:image).
              allowing('image/png', 'image/gif').
              rejecting('text/plain', 'text/xml') }

  it { should belong_to :category }
  it { should have_many :loans }
  it { should belong_to :country }
  it { should have_many :orders }

end
