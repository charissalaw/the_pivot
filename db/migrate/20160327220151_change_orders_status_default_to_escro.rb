class ChangeOrdersStatusDefaultToEscro < ActiveRecord::Migration
  def change
    change_column_default(:orders, :status, 'escrow')
  end
end
