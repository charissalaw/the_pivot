class RemoveInactiveFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :inactive, :string
    add_column :projects, :status, :string, default: "active"
  end
end
