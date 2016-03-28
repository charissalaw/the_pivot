class RemoveEmailFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :fullname, :string
    remove_column :orders, :email, :string
  end
end
