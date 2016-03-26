class Project < ActiveRecord::Base
  belongs_to :category
  belongs_to :borrower
  has_many :loans
  has_many :orders, through: :loans
  belongs_to :country
  before_save :build_slug

  validates :name, presence: true, uniqueness: true
  validates :goal, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :country_id,  presence: true
  validates :borrower_id, presence: true

  has_attached_file :image,
      styles: { index: '275x175>', show: '550x350<', small: '137.5x87.5>' },
      default_url: "https://source.unsplash.com/random"

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  scope :active_projects, -> { where(inactive: false) }

  def build_slug
    if name
      self.slug = name.gsub(" ", "-").gsub(",","")
    end
  end

  def display_goal
    "$#{goal.to_i / 100}"
  end

  def self.active_index
    where(inactive: false).order(:name)
  end

  def self.inactive_index
    where(inactive: true).order(:name)
  end

  def inactive?
    inactive
  end

  def self.category_distribution
    group(:category).count.map { |k, v| [k.name, v] }
  end
end
