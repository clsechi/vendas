class AddFieldsToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :category_id, :integer
    add_column :orders, :plan_id, :integer
    add_column :orders, :periodicity_id, :integer
    add_column :orders, :value, :decimal
  end
end
