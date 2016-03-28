class CreateBorrowerAttributes < ActiveRecord::Migration
  def change
    create_table :borrower_attributes do |t|
      t.string :category
      t.string :label
      t.integer :score

      t.timestamps null: false
    end
  end
end
