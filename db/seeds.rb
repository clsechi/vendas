Seller.create(email: 'admin@admin.com', password: '12345678', admin: true, name: 'Admin')

seller = Seller.create(email: 'seller@email.com', password: '123456', name: 'Vendedor')

customer_pf = Customer.create(name: 'ClientePF', address: 'Rua 123 de Maio', cpf:'969.704.520-85', email:'customer_pf@email.com', phone: '(11)2222-3333', birth_date: '2018-01-30')
customer_pj = Customer.create(name: 'ClientePJ', address: 'Rua 123 de Maio', cnpj:'25.729.960/0001-18', email:'customer_pj@email.com', company_name: 'Company', contact: '122223333', birth_date: '')

Order.create(status: 'Ativo', seller: seller, customer: customer_pf, product_id: 1, category_id: 1, plan_id: 1, value: 25.50, periodicity_id: 1, product_name: 'Hospedagem I')

Order.create(status: 'Ativo', seller: seller, customer: customer_pj, product_id: 2, category_id: 1, plan_id: 1, value: 30.00, periodicity_id: 1, product_name: 'Hospedagem II')
