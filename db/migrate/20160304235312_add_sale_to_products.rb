class AddSaleToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :sale?, :boolean, default: false
    add_column :projects, :sale_goal, :integer
  end
end
