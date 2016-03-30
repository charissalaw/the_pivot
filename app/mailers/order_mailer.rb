class OrderMailer < ApplicationMailer
  def order_email(order)
    @order = order
    @url = "http://lendingowl.herokuapp.com"
    mail(to: @order.user.email, subject: '🎉Thanks for your loan!🎉')
  end
end
