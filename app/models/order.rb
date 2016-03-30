class Order < ActiveRecord::Base
  belongs_to :user
  has_many :loans
  has_many :projects, through: :loans
  has_many :comments

  validates :user_id, presence: true

  scope :processed_orders, -> { where(status: "escrow" || "completed") }

  scope :cancelled_orders, -> { where(status: "cancelled") }

  def send_to_escrow
    Escrow.send_to_escrow(self)
  end

  def self.total_revenue
    processed_orders.sum(:order_total)
  end

  def self.daily_average_revenue
    return if Order.count == 0
    total_revenue / processed_orders.group(:created_at).count.length
  end

  def self.weekly_average_revenue
    return if Order.count == 0
    total_revenue / processed_orders.group_by_week(:created_at).count.length
  end

  def self.search(search)
    where('first_name || last_name || fullname ILIKE ?', "%#{search}%").uniq
  end

  def self.search_by_date(search)
    date = Date.parse(search)
    where(updated_at: date.beginning_of_day..date.end_of_day)
  end

  def total
    loans.sum(:quantity)
  end

  def display_total
    "$#{total}"
  end

  def project_quantity
    loans.count
  end

  def name
    "#{first_name} #{last_name}"
  end

  def self.by_date
    order(updated_at: :desc)
  end

  def date
    updated_at.strftime("%B %-d, %Y")
  end

  def self.top_country
    return if Order.count == 0
    Project.joins(:country).group("countries.name").count.sort_by { |country, n| n }.last[0]
  end

  def process_stripe_payment
    customer = Stripe::Customer.create email: user.email,
                                       card: card_token
    Stripe::Charge.create customer: customer.id,
                          amount: total,
                          description: id,
                          currency: 'usd'
  end
end
