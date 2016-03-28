class Country < ActiveRecord::Base
  has_many  :projects
  validates :name, presence: true
  before_save :build_slug

  def build_slug
    self.slug = name.parameterize
  end
end
