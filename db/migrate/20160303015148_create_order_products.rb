class CreateOrderProjects < ActiveRecord::Migration
  def change
    create_table :order_projects do |t|
      t.references :project, index: true, foreign_key: true
      t.references :order, index: true, foreign_key: true
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
