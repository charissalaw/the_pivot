class OrderMailer < ApplicationMailer
  def order_email(order)
    @order = order
    @url = "http://lendingowl.herokuapp.com"
    mail(to: @order.user.email, subject: '🎉Alright, Alright, Alright.  Your joe is on the way!🎉')
  end
end
