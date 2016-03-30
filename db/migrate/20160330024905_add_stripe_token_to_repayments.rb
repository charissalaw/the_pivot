class AddStripeTokenToRepayments < ActiveRecord::Migration
  def change
    add_column :repayments, :stripeToken, :string
  end
end
