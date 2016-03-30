require 'spec_helper'

RSpec.describe OrderMailer do
  describe 'email' do
    before :each do
      create(:lender_role)
      create(:borrower_role)
      borrower_user = create(:user, fullname: "borrower jones", email: "borrow@email.com")
      @lender_user = create(:user, fullname: "lender smith", email: "lender@email.com")
      borrower_user.roles << Role.find_by(name:"borrower")
      borrower = create(:borrower)
      borrower.update(user_id: borrower_user.id)
      category1 = create(:category)
      country1 = create(:country)
      project_active1 = create(:project, borrower_id: borrower.id, category_id: category1.id, country_id: country1.id)
      @order = @lender_user.orders.create
      loan1 = @order.loans.create(quantity: 25, project_id: project_active1.id)
      loan2 = @order.loans.create(quantity: 30, project_id: project_active1.id)
      @order.send_to_escrow
    end

    let(:mail) { OrderMailer.order_email(@order) }

    it 'renders the subject' do
      expect(mail.subject).to eql('🎉Thanks for your loan!🎉')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([@lender_user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['lendingowl1511@gmail.com'])
    end

    it 'assigns @order.fullname' do
      expect(mail.body.encoded).to match(@lender_user.fullname)
    end
  end
end
