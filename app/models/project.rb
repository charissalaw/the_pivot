class Project < ActiveRecord::Base
  belongs_to :category
  belongs_to :borrower
  has_many :loans
  has_many :repayments
  has_many :orders, through: :loans
  belongs_to :country
  before_validation :build_slug

  validates :name, presence: true, uniqueness: true
  validates :goal, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :country_id,  presence: true
  validates :borrower_id, presence: true
  validates :status, presence: true
  validates :slug, uniqueness: true


  has_attached_file :image,
      styles: { index: '275x175>', show: '550x350<', small: '137.5x87.5>' },
      default_url: "https://source.unsplash.com/random"

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  scope :active_projects, -> { where(status: "active") }

  def build_slug
    if name
      self.slug = name.parameterize
    end
  end

  def display_goal
    "$#{goal.to_i / 100}"
  end

  def display_goal_remaining
    "$#{(goal.to_i - loans.sum(:quantity)) / 100}"
  end

  def remaining_goal
    (goal.to_i - loans.sum(:quantity))
  end

  def self.active_index
    where(status: "active").order(:name)
  end

  def self.inactive_index
    where(status: "deactive").order(:name)
  end

  def self.completed_index
    where(status: "completed").order(:name)
  end

  def self.category_distribution
    group(:category).count.map { |k, v| [k.name, v] }
  end
end
