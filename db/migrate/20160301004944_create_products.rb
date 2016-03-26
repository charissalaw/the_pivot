class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :goal
      t.string :description
      t.string :image_url
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
