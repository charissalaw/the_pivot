class BorrowersProjectsSeed
  def self.generate_borrowers
    30.times do
      fullname = Faker::Name.name
      email = Faker::Internet.free_email(fullname.split[0])
      user = User.new(fullname: fullname, email: email, password: "password")

      if user.save
        puts "Created User: #{user.fullname}."
        borrower = Borrower.new(borrower_params)
        if borrower.save
          puts "Created Borrower: #{borrower.id}."
          build_borrower_dashboard(user, borrower)
        end
      end
    end

    test_borrower = User.new(fullname: "Borrower", email: "borrower@lendingowl.com", password: "password")
    if test_borrower.save
      puts "Created User: #{test_borrower.fullname}."
      borrower = Borrower.new(borrower_params)
      if borrower.save
        puts "Created Borrower: #{borrower.id}."
        build_borrower_dashboard(test_borrower, borrower)
      end
    end
  end

private
  def self.borrower_params
    {description: Faker::Lorem.paragraph,
      annual_income: Random.new.rand(300000),
      monthly_housing: Random.new.rand(30000),
      monthly_credit_pmt: Random.new.rand(30000),
      dependents: Random.new.rand(7)}
  end

  def self.build_borrower_dashboard(user, borrower)
    user.roles << Role.find_by(name:"borrower")
    user.borrower = borrower
    date = Faker::Time.between(DateTime.now - 700, DateTime.now - 2)
    user.update(created_at: date, updated_at: date)
    categories = category_ids
    countries = country_ids
    2.times do
      project = borrower.projects.create(name:Faker::Book.title, price: 2500, description:Faker::Lorem.paragraph, image: open(image_arr.sample), category_id: categories.sample, country_id: countries.sample)
      puts "Created Project: #{project.name}."
    end
  end

  def self.category_ids
    Category.pluck(:id)
  end

  def self.country_ids
    Country.pluck(:id)
  end

  def self.image_arr
    ["https://s3.amazonaws.com/littleowl-turing/products/Aeropress.png",
      "https://s3.amazonaws.com/littleowl-turing/products/Baratza+Esatto+Accessory.png",
      "https://s3.amazonaws.com/littleowl-turing/products/Bonavita+1900TS+Brewer.png",
      "https://s3.amazonaws.com/littleowl-turing/products/Dteaming+Pitcher%2C+12oz.png",
      "https://s3.amazonaws.com/littleowl-turing/products/Hario+Buono+Kettle.png",
      "https://s3.amazonaws.com/littleowl-turing/products/Takahiro+Kettle.png",
      "https://s3.amazonaws.com/littleowl-turing/products/The+Automated.png",
      "https://s3.amazonaws.com/littleowl-turing/products/The+Durable+Basic.png",
      "https://s3.amazonaws.com/littleowl-turing/products/Tsuki+Usagi+Jirushi+Slim+Pot.png",
      "https://s3.amazonaws.com/littleowl-turing/products/banko_gutiti_ethiopia.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/bola_de_oro.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/cheri_ethiopia.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/derar_ela_ethiopia.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/espresso_neat_blend.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/finca_san_matias.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/gatchatha_aa_kenya.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/inter_continental_pack.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/kiamabara.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/kiangoi_kenya.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/kii_kenya.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/los_carillos_guatemala.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/nitsu_ruz_ethiopia.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/santa_clara_panama.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/tanzania.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/terra_bella.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/espresso+set.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/gifts/Modern_Art_Desserts.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/gifts/blue+mug.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/gifts/chocolat.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/gifts/fancy+pourover.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/gifts/gift+card+-+holiday.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/gifts/ornaments.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/gifts/pitcher.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/terra_bella.jpg",
      "https://s3.amazonaws.com/littleowl-turing/products/espresso+set.jpg"]
  end
end

BorrowersProjectsSeed.generate_borrowers
