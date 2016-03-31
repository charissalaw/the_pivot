class Loan < ActiveRecord::Base
  belongs_to :project
  belongs_to :order
  before_save :check_status

  validates :quantity, presence: true
  validates :project_id, presence: true
  validates :order_id, presence: true

  def check_status
    project.check_status
  end

  def self.top_project
    return if Loan.count == 0
    Project.find(top_project_info[0])
  end

  def self.top_project_info
    group(:project_id).sum(:quantity).sort_by { |project, count| count }.last
  end

  def display_total
    "$#{quantity/100}"
  end

  def date
    updated_at.strftime("%B %-d, %Y")
  end

  def self.active_loans
    where(status: "active").order(:created_at)
  end

  def self.paid
    where(status: "paid").order(:created_at)
  end
end
