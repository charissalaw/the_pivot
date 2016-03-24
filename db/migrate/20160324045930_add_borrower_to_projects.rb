class AddBorrowerToProjects < ActiveRecord::Migration
  def change
    add_reference :projects, :borrower, index: true, foreign_key: true
  end
end
