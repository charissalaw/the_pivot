class Escrow < ActiveRecord::Base
  belongs_to :project
  validates :project_id, presence: true
  
  def self.send_to_escrow(order)
    order.loans.each do |loan|
      escrow = Escrow.find_or_create_by(project_id: loan.project_id)
      new_debt = escrow.debt_amount.to_i + loan.quantity
      escrow.update(debt_amount: new_debt)
    end
  end

end
