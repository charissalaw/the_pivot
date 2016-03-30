class RemoveSaleFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :sale, :boolean
    remove_column :projects, :sale_goal, :string
  end
end
