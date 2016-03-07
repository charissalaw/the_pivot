class User < ActiveRecord::Base
  before_save :build_full_name
  has_secure_password
  has_many :orders
  has_many :order_products, through: :orders

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  enum role: %w(default admin super_admin)

  def build_full_name
    self.fullname = "#{first_name} #{last_name}"
  end

  def admin_message
    ["Life is good, #{self.first_name}."]
  end

  def name
    "#{first_name} #{last_name}"
  end
end
