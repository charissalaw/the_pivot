class CreateBorrowers < ActiveRecord::Migration
  def change
    create_table :borrowers do |t|
      t.text :description
      t.integer :annual_income
      t.integer :monthly_housing
      t.integer :monthly_credit_pmt
      t.integer :dependents
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end

end
