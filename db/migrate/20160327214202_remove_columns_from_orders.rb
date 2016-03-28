class RemoveColumnsFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :street, :string
    remove_column :orders, :unit, :string
    remove_column :orders, :city, :string
    remove_column :orders, :state, :string
    remove_column :orders, :zip, :string
  end
end
