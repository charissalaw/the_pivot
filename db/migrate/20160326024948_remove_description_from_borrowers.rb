class RemoveDescriptionFromBorrowers < ActiveRecord::Migration
  def change
    remove_column(:borrowers, :description)
  end
end
