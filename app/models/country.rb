class Country < ActiveRecord::Base
  has_many  :projects
  validates :name, presence: true
  before_save :build_slug

  def active_projects
    projects.active_projects
  end

  def build_slug
    self.slug = name.parameterize
  end
end
