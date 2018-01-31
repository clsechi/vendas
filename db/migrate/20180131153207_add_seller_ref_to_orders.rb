class AddSellerRefToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :seller, foreign_key: true
  end
end
