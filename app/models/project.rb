class Project < ActiveRecord::Base
  belongs_to :category
  belongs_to :borrower
  has_many :loans
  has_many :repayments
  has_many :orders, through: :loans
  belongs_to :country
  before_validation :build_slug
  before_create :convert_dollars

  validates :name, presence: true, uniqueness: true
  validates :goal, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :country_id,  presence: true
  validates :borrower_id, presence: true
  validates :status, presence: true
  validates :slug, uniqueness: true
  validates_numericality_of :goal, only_integer: true


  has_attached_file :image,
      styles: { index: '275x175>', show: '550x350<', small: '137.5x87.5>' },
      default_url: "https://source.unsplash.com/random"

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  scope :active_projects, -> { where(status: "active") }
  scope :funded_projects, -> { where(status: "funded") }

  def build_slug
    if name
      self.slug = name.parameterize
    end
  end

  def convert_dollars
    self.goal = goal * 100
  end

  def check_status
    unless loans.sum(:quantity) < goal
      self.update_attributes(status: "funded")
    end
  end

  def display_goal
    "$#{goal.to_i / 100}"
  end

  def display_goal_remaining
    "$#{((goal.to_i) - loans.sum(:quantity)) / 100}"
  end

  def remaining_goal
    ((goal.to_i) - loans.sum(:quantity)) / 100
  end

  def percent_funded
    ((loans.sum(:quantity))/(goal.to_f) * 100).round
  end

  def self.active_index
    where(status: "active").order(:name)
  end

  def self.inactive_index
    where(status: "deactive").order(:name)
  end

  def funded?
    status == "funded"
  end

  def self.completed_index
    where(status: "completed").order(:name)
  end

  def self.category_distribution
    group(:category).count.map { |k, v| [k.name, v] }
  end

  def self.search(search)
    where('name ILIKE ?', "%#{search}%").uniq
  end

  def self.search_by_category(search)
    where(category_id:search).uniq
  end

  def self.search_by_country(search)
    where(country_id:search).uniq
  end

  def self.by_date
    order(updated_at: :desc)
  end
end
