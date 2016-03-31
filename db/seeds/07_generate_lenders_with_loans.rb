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

        rand(1..3).times do
          order = user.orders.new

          if order.save
            puts "Created Order: #{order.id}."
            order_date = Faker::Time.between(date, DateTime.now - 1)
            order.update(created_at: order_date, updated_at: order_date)

            rand(1..4).times do
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
  end
end

LendersLoansSeed.generate_lenders
