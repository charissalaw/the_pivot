class Borrower < ActiveRecord::Base
  belongs_to :user
  has_many :projects
  validates :annual_income, presence: true, numericality: { only_integer: true, less_than: 5_000_000 }
  validates :monthly_housing, presence: true
  validates :monthly_credit_pmt, presence: true
  validates :dependents, presence: true
  validates :username, presence: true, uniqueness: true

  def self.search(search)
    joins(:user).where('first_name || last_name || fullname ILIKE ?', "%#{search}%").uniq
  end

  def self.search_by_category(search)
    joins(projects: :category).where('categories.name ILIKE ?', "%#{search}%").uniq
  end

  def self.search_by_country(search)
    joins(projects: :country).where('countries.name ILIKE ?', "%#{search}%").uniq
  end

  def self.search_by_date(search)
    date = Date.parse(search)
    where(updated_at: date.beginning_of_day..date.end_of_day)
  end

  def self.by_date
    order(updated_at: :desc)
  end

end
