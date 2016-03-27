class Borrower < ActiveRecord::Base
  belongs_to :user
  has_many :projects
  has_many :loans, through: :projects

  validates :annual_income, presence: true, numericality: { only_integer: true, less_than: 5_000_000 }
  validates :monthly_housing, presence: true
  validates :monthly_credit_pmt, presence: true
  validates :dependents, presence: true
  validates :username, presence: true, uniqueness: true
end
