require "rails_helper"

RSpec.feature "BorrowerViewsAllOrders", type: :feature do
  scenario "they see all of the loans for projects" do
    create(:lender_role)
    create(:borrower_role)
    borrower_user = create(:user, fullname: "borrower jones", email: "borrow@email.com")
    lender_user = create(:user, fullname: "lender smith", email: "lender@email.com")
    borrower_user.roles << Role.find_by(name:"borrower")
    borrower = create(:borrower)
    borrower.update(user_id: borrower_user.id)
    category1 = create(:category)
    category2 = create(:category, name: "space!")
    country1 = create(:country)
    country2 = create(:country, name: "nicaragua")
    project_active1 = create(:project, borrower_id: borrower.id, category_id: category1.id, country_id: country1.id)
    project_active2 = create(:project, name: "rockets", borrower_id: borrower.id, category_id: category2.id, country_id: country2.id)
    order = lender_user.orders.create
    loan1 = order.loans.create(quantity: 25, project_id: project_active1.id)
    loan2 = order.loans.create(quantity: 30, project_id: project_active1.id)
    loan3 = order.loans.create(quantity: 35, project_id: project_active2.id)
    borrower_user.borrower.loans => "all loans"
  #   click_on "login"
  #   fill_in "email", with: admin.email
  #   fill_in "password", with: admin.password
  #   click_on "login"
  #   visit admin_dashboard_path
  #
  #   click_on "active orders"
  #
  #   expect(current_path).to eq(admin_orders_path)
  #
  #   within "tr##{order1.id}-order" do
  #     expect(page).to have_content(order1.id)
  #     expect(page).to have_content(order1.first_name)
  #     expect(page).to have_content(order1.last_name)
  #     expect(page).to have_content(order1.total)
  #     expect(page).to have_content(order1.project_quantity)
  #     expect(page).to_not have_content(order2.total)
  #     select "completed", from: "order_status"
  #     click_on "update"
  #   end
  #
  #   expect(current_path).to eq(admin_orders_path)
  #   expect(Order.first.status).to eq("completed")
  #
  #   click_on(order1.id)
  #
  #   expect(current_path).to eq(admin_order_path(order1.id))
  #   within "div#order-information" do
  #     expect(page).to have_content(order1.id)
  #     expect(Order.first.status).to eq("completed")
  #     expect(page).to have_button("update")
  #   end
  #
  #   within "div#order-comments" do
  #     expect(Order.first.comments.last.comment).to eq("Test comment")
  #     expect(page).to have_button("add comment")
  #   end
  #
  #   within "div#customer-information" do
  #     expect(page).to have_content(order1.first_name)
  #     expect(page).to have_content(order1.last_name)
  #     expect(page).to have_content("1600 pennslyvania")
  #     expect(page).to have_content(order1.city)
  #     expect(page).to have_content(order1.state)
  #     expect(page).to have_content(order1.zip)
  #   end
  #
  #   expect(page).to have_content(loan1.project.name)
  #   expect(page).to have_content(loan1.quantity)
  #   expect(page).to have_content(loan1.project.display_goal)
  #   expect(page).to have_content(loan1.display_total)
  end
end
