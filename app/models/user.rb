class User < ActiveRecord::Base
  has_secure_password
  has_one :borrower
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :orders
  has_many :order_projects, through: :orders
  before_save :build_name
  before_save :assign_role

  validates :fullname, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def admin?
    roles.exists?(name:"admin")
  end

  def borrower?
    roles.exists?(name:"borrower")
  end

  def lender?
    roles.exists?(name:"lender")
  end

  def build_name
    self.first_name = fullname.split[0]
    self.last_name = fullname.split[1..-1].join(" ")
  end

  def admin_message
    ["Life is good, #{self.first_name}."]
  end

  def name
    "#{first_name} #{last_name}"
  end

  def assign_role
    self.roles << Role.find_by(name: "lender")
  end
end
