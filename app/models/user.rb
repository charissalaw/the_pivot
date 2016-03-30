class User < ActiveRecord::Base
  has_secure_password
  has_one :borrower
  has_many :projects, through: :borrower
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :orders
  has_many :loans, through: :orders
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

  def loans?
    loans.first
  end

  def dashboard
    if admin?
      "/admin/users/#{id}"
    elsif borrower?
      "/borrower/users/#{id}"
    else
      "/"
    end
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
    if !lender?
      self.roles << Role.find_by(name: "lender")
    end
  end

  def balance
    borrower.loans.sum(:quantity)
  end

  def display_balance
    "$#{balance}"
  end

  def funded_projects
    borrower.projects.funded_index
  end

  def total_goal
    (self.projects.sum(:goal))/100
  end

  def total_funded
    sum = 0
    self.projects.each do |project|
      sum += project.loans.sum(:quantity)
    end
    sum/100
  end

  def loan_count
    count = 0
    self.projects.each do |project|
      count += project.loans.count
    end
    count
  end
end
