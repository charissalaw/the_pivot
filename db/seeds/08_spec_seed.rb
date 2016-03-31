class SpecSeed
  def self.generate_admin
    admin = User.create(fullname: "Jorge Jorge", email: "jorge@turing.io", password: "password")
    admin.roles << Role.find_by(name:"admin")
    admin.roles << Role.find_by(name:"borrower")
    puts "Created Admin: #{admin.email}."
  end

  def self.generate_borrower
    test_borrower = User.new(fullname: "Andrew Andrew", email: "andrew@turing.io", password: "password")
    if test_borrower.save
      puts "Created User: #{test_borrower.fullname}."
      borrower = Borrower.new(borrower_params(test_borrower))
      if borrower.save
        puts "Created Borrower: #{borrower.id}."
        build_borrower_dashboard(test_borrower, borrower)
      end
    end
  end

  def self.generate_lenders
    fullname = "Josh Mejia"
    email = "josh@turing.io"
    user = User.new(fullname: fullname, email: email, password: "password")

    if user.save
      puts "Created User: #{user.name}."
      date = Faker::Time.between(DateTime.now - 700, DateTime.now - 2)
      user.update(created_at: date, updated_at: date)

      rand(4).times do
        order = user.orders.new

        if order.save
          puts "Created Order: #{order.id}."
          order_date = Faker::Time.between(date, DateTime.now - 1)
          order.update(created_at: order_date, updated_at: order_date)

          rand(1..2).times do
            loan = order.loans.create(project_id: Project.where(status:"active").order("RANDOM()").first.id, quantity: (5..50).step(5).to_a.sample * 100)

            loan.update(created_at: order_date, updated_at: order_date)
            puts "Created Loan: #{loan.project.name}."
          end
          total = order.total
          order.update(order_total: total)
          order.send_to_escrow
        end
      end
    end
  end

private
  def self.borrower_params(user)
    { annual_income: 0,
      monthly_housing: 0,
      monthly_credit_pmt: 0,
      dependents: 0}
  end

  def self.build_borrower_dashboard(user, borrower)
    user.roles << Role.find_by(name:"borrower")
    user.borrower = borrower
    date = Faker::Time.between(DateTime.now - 700, DateTime.now - 2)
    user.update(created_at: date, updated_at: date)
    categories = category_ids
    countries = country_ids

    5.times do
      project = borrower.projects.create(name:Faker::Book.title, goal: (10..500).step(5).to_a.sample, description:Faker::Lorem.paragraph, category_id: categories.sample, country_id: countries.sample, image: "https://source.unsplash.com/random")
      puts "Created Project: #{project.name}, #{project.goal}."
    end
  end

  def self.category_ids
    Category.pluck(:id)
  end

  def self.country_ids
    Country.pluck(:id)
  end
end

SpecSeed.generate_admin
SpecSeed.generate_borrower
SpecSeed.generate_lenders
