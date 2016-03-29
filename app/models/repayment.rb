class Repayment < ActiveRecord::Base
  belongs_to :project
  validates :project_id, presence: true

  def self.remaining_pmt(project)
    repayment = Repayment.find_or_create_by(project_id: project.id)
    display_remaining_pmt(project, repayment)
  end

  def self.update_repayment(project)
    repayment = Repayment.find_or_create_by(project_id: project.id)
  end

  def self.display_remaining_pmt(project, repayment)
    "$#{(project.goal - repayment.amount_paid)/100}"
  end

end
