class BorrowersProjectsSeed
  def self.generate_borrowers
    15.times do
      fullname = Faker::Name.name
      email = Faker::Internet.free_email(fullname.split[0])
      user = User.new(fullname: fullname, email: email, password: "password")
      if user.save
        puts "Created User: #{user.fullname}."
        borrower = Borrower.new(borrower_params(user))
        if borrower.save
          puts "Created Borrower: #{borrower.id}."
          build_borrower_dashboard(user, borrower)
        end
      end
    end

    test_borrower = User.new(fullname: "Borrower", email: "borrower@lendingowl.com", password: "password")
    if test_borrower.save
      puts "Created User: #{test_borrower.fullname}."
      borrower = Borrower.new(borrower_params(test_borrower))
      if borrower.save
        puts "Created Borrower: #{borrower.id}."
        build_borrower_dashboard(test_borrower, borrower)
      end
    end
  end

private
  def self.borrower_params(user)
    { annual_income: Random.new.rand(300000),
      monthly_housing: Random.new.rand(30000),
      monthly_credit_pmt: Random.new.rand(30000),
      dependents: Random.new.rand(7)}
  end

  def build_username
    fullname.downcase.gsub(/[()-,. ']/, "-") + "-#{user.id}"
  end

  def self.build_borrower_dashboard(user, borrower)
    user.roles << Role.find_by(name:"borrower")
    user.borrower = borrower
    date = Faker::Time.between(DateTime.now - 700, DateTime.now - 2)
    user.update(created_at: date, updated_at: date)
    categories = category_ids
    countries = country_ids
    1.times do
      project = borrower.projects.create(name:Faker::Book.title, goal: rand(25..1500), description:Faker::Lorem.paragraph, category_id: categories.sample, country_id: countries.sample, image: "https://source.unsplash.com/random")
      puts "Created Project: #{project.name}."
    end
  end

  def self.category_ids
    Category.pluck(:id)
  end

  def self.country_ids
    Country.pluck(:id)
  end
end

BorrowersProjectsSeed.generate_borrowers
