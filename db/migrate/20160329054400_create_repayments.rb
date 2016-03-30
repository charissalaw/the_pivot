class CreateRepayments < ActiveRecord::Migration
  def change
    create_table :repayments do |t|
      t.references :project, index: true, foreign_key: true
      t.integer :amount_paid

      t.timestamps null: false
    end
  end
end
