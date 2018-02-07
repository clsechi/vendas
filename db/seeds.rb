# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Seller.create(email: 'admin@admin.com', password: '12345678', admin: true, name: 'Admin')

seller = Seller.create(email: 'seller@email.com', password: '123456', name: 'Vendendor')

customer_pf = Customer.create(name: 'ClientePF', address: 'Rua 123 de Maio', cpf:'111.111.111-11', email:'customer_pf@email.com', phone: '(11)2222-3333', birth_date: '2018-01-30')
customer_pj = Customer.create(name: 'ClientePJ', address: 'Rua 123 de Maio', cnpj:'03.847.655/0001-98', email:'customer_pj@email.com', company_name: 'Company', contact: '122223333')

Order.create(status: 'Ativo', seller: seller, customer: customer_pf, product_id: 1, category_id: 1, plan_id: 1, price: 25.50)
Order.create(status: 'Ativo', seller: seller, customer: customer_pj, product_id: 2, category_id: 1, plan_id: 1, price: 30.00)
