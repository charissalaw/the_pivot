class AdminSeed
  def self.generate_admin
    admin = User.create(fullname: "admin", email: "admin@lendingowl.com", password: "password")
    admin.roles << Role.find_by(name:"admin")
    admin.roles << Role.find_by(name:"borrower")
    puts "Created Admin: #{admin.email}."
  end
end

AdminSeed.generate_admin
