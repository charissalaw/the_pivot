class RolesSeed
  def self.generate_roles
    roles.each do |role|
      seed = Role.create(name:role)
      puts "Created Role: #{seed.name}."
    end
  end

private
  def self.roles
    ["lender", "borrower", "admin"]
  end
end

RolesSeed.generate_roles
