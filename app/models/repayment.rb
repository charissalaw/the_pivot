class Repayment < ActiveRecord::Base
  belongs_to :project
  has_many :loans, through: :project
  validates :project_id, presence: true
  validates :amount_paid, presence: true
  before_create :convert_dollars

  def convert_dollars
    self.amount_paid = amount_paid * 100
  end

  def process_project
    project.check_repayment_status
  end

  def process_stripe_payment
    customer = Stripe::Customer.create email: user.email,
                                       card: card_token
    Stripe::Charge.create customer: customer.id,
                          amount: amount_paid,
                          description: id,
                          currency: 'usd'
  end
end
