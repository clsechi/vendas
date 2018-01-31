class RemoveSellerFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :seller, :string
  end
end
