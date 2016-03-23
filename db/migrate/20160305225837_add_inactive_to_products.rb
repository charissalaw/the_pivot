class AddInactiveToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :inactive, :boolean, default: false
  end
end
