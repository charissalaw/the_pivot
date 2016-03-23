class Category < ActiveRecord::Base
  has_many :projects

  validates :name, presence: true
  validates :name, uniqueness: true

  def active_projects
    projects.active_projects
  end
end
