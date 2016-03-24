class AdminSeed
  def self.generate_admin
    admin = User.create(fullname: "admin", email: "admin@lendingowl.com", password: "password")
    admin.roles << Role.find_by(name:"admin")
    puts "Created Admin: #{admin.email}."
  end
end

AdminSeed.generate_admin
