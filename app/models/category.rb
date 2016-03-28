class Category < ActiveRecord::Base
  has_many :projects

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :slug, uniqueness: true

  before_validation :build_slug

  def active_projects
    projects.active_projects
  end

  def build_slug
    if name
      self.slug = name.parameterize
    end
  end
end
