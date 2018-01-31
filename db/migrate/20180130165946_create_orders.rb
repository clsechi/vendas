class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :status
      t.references :seller, foreign_key: true
      t.references :customer, foreign_key: true
      t.integer :product_id

      t.timestamps
    end
  end
end
