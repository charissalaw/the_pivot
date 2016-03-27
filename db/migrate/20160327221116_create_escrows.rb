class CreateEscrows < ActiveRecord::Migration
  def change
    create_table :escrows do |t|
      t.integer :debt_amount, default: 0
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
