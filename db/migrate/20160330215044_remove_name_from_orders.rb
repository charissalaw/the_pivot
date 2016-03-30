class RemoveNameFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :first_name, :string
    remove_column :orders, :last_name, :string
  end
end
