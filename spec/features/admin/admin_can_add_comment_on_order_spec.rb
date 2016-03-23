require "rails_helper"

RSpec.feature "AdminCanCommentOnOrder", type: :feature do
  scenario "they comment on specific orders" do
    coffee = Category.create(name:"coffee")

    project1 = coffee.projects.create(name: "Finca San Matias",
                                      price: 2500,
                                      description: "Es todo que necessita.",
                                      )
    project2 = coffee.projects.create(name: "Gatchatha AA Kenya",
                                      price: 2000,
                                      description: "Gatchatha have it.",
                                      )
    project3 = coffee.projects.create(name: "Inter Continental Pack",
                                      price: 4000,
                                      description: "Study abroad.",
                                      )

    user = User.create(first_name: "john",
                       last_name: "adams",
                       fullname: "john adams",
                       email: "email@foundingfathers.biz",
                       password: "password")

    order1 = user.orders.create(street: "1600 pennslyvania",
                                city: "washington",
                                state: "District of Columbia",
                                zip: "46250",
                                fullname: "jonathon adams",
                                first_name: "jonathon",
                                last_name: "adams",
                                email: "spam@foundingfathers.biz")

    order1.order_projects.create(project_id: project1.id,
                                 quantity: 10)

    order1.order_projects.create( project_id: project3.id,
                                  quantity: 11)
    order1.comments.create(comment: "Test comment")

    order2 = user.orders.create(street: "1600 pennslyvania",
                                city: "washington",
                                state: "District of Columbia",
                                zip: "46250",
                                fullname: "jonathon adams",
                                first_name: "jonathon",
                                last_name: "adams",
                                email: "spam@foundingfathers.biz")

    order2.order_projects.create(project_id: project2.id, quantity: 1)
    order2.order_projects.create(project_id: project3.id, quantity: 2)

    admin = User.create(first_name: "john",
                        last_name: "admin",
                        fullname: "john admin",
                        email: "admin@example.com",
                        password: "password",
                        role: 1)

    visit "/"
    click_on "login"
    fill_in "email", with: admin.email
    fill_in "password", with: admin.password
    click_on "login"
    visit admin_dashboard_path

    click_on "active orders"

    click_on(order1.id)

    within "div#order-comments" do
      expect(Order.first.comments.last.comment).to eq("Test comment")
      expect(page).to have_button("add comment")

      click_on("add comment")
    end

    expect(page).to have_content("Sorry, friend.  Something went wrong :(... Please try again.")

    within "div#order-comments" do
      fill_in "comment", with: "another comment"
      click_on("add comment")
      expect(Order.first.comments.last.comment).to eq("another comment")
    end
  end
end
