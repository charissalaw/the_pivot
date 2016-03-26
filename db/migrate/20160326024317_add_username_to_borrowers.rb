class AddUsernameToBorrowers < ActiveRecord::Migration
  def change
    add_column :borrowers, :username, :string
  end
end
