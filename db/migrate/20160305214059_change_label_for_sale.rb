class ChangeLabelForSale < ActiveRecord::Migration
  def change
    rename_column :projects, :sale?, :sale
  end
end
