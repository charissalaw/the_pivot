class Borrower < ActiveRecord::Base
  belongs_to :user
  has_many :projects
  has_many :loans, through: :projects

  validates :annual_income, presence: true
  validates :monthly_housing, presence: true
  validates :monthly_credit_pmt, presence: true
  validates :dependents, presence: true

  def self.search(search)
    joins(:user).where('first_name || last_name || fullname ILIKE ?', "%#{search}%").uniq
  end

  def self.search_by_category(search)
    joins(:projects).where(projects: {category_id:search}).uniq
  end

  def self.search_by_country(search)
    joins(:projects).where(projects: {country_id:search}).uniq
  end

  def self.search_by_date(search)
    date = Date.parse(search)
    where(updated_at: date.beginning_of_day..date.end_of_day)
  end

  def self.by_date
    order(updated_at: :desc)
  end

end
