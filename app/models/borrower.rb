class Borrower < ActiveRecord::Base
  belongs_to :user
  has_many :projects
  validates :description, presence: true
  validates :annual_income, presence: true, numericality: { only_integer: true, less_than: 5_000_000 }
  validates :monthly_housing, presence: true
  validates :monthly_credit_pmt, presence: true
  validates :dependents, presence: true
end
