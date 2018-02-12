class AddValidationsToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :ready, :boolean
    add_column :orders, :already_posted, :boolean
  end
end
