class RemoveImageUrlFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :image_url, :string
  end
end
