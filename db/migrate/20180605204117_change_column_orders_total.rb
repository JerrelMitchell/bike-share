class ChangeColumnOrdersTotal < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :total, :bigint, default: 0
  end
end
