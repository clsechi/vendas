class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :address
      t.string :cpf
      t.string :cnpj
      t.string :email
      t.string :phone
      t.date :birth_date
      t.string :company_name
      t.string :contact

      t.timestamps
    end
  end
end
