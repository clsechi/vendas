class AddNameToSellers < ActiveRecord::Migration[5.1]
  def change
    add_column :sellers, :name, :string
  end
end
