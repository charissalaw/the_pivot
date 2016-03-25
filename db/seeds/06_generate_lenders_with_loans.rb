class LendersLoansSeed
  def self.generate_lenders
    100.times do
      fullname = Faker::Name.name
      email = Faker::Internet.free_email(fullname.split[0])
      user = User.new(fullname: fullname, email: email, password: "password")

      if user.save
        puts "Created User: #{user.name}."
        date = Faker::Time.between(DateTime.now - 700, DateTime.now - 2)
        user.update(created_at: date, updated_at: date)

        rand(1..4).times do
          order = user.orders.new(street: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state, zip: Faker::Address.zip, fullname: fullname, email: email)

          if order.save
            puts "Created Order: #{order.id}."
            order_date = Faker::Time.between(date, DateTime.now - 1)
            order.update(created_at: order_date, updated_at: order_date)
            rand(0..4).times do
              comment = order.comments.create(comment: Faker::StarWars.quote)
              comment_date = Faker::Time.between(order_date, DateTime.now - 1)
              comment.update(created_at: comment_date, updated_at: comment_date)
            end

            rand(1..7).times do
              loan = order.loans.create(project_id: Project.order("RANDOM()").first.id, quantity: rand(1..10))

              loan.update(created_at: order_date, updated_at: order_date)
              puts "Created Loan: #{loan.project.name}."
            end
            total = order.total
            order.update(order_total: total)

            statuses = ["paid","paid","paid","paid","paid","completed","completed","completed","completed","completed", "completed","completed","completed","completed","completed","cancelled"]

            order.update(status: statuses.sample)
          end
        end
      end
    end
  end
end

LendersLoansSeed.generate_lenders
