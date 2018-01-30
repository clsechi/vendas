class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.date :creation_date
      t.string :status
      t.string :seller
      t.references :customer, foreign_key: true
      t.string :product

      t.timestamps
    end
  end
end
