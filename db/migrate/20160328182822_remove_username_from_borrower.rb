class RemoveUsernameFromBorrower < ActiveRecord::Migration
  def change
    remove_column :borrowers, :username, :string
  end
end
