require 'rails_helper'

feature 'Admin resend order' do
  scenario 'successfully' do
    admin = create(:seller, admin: true)
    seller = create(:seller, email: 'user@email.com')
    customer = create(:customer, :legal)
    order = create(:order, customer: customer,
                           seller: seller,
                           ready: true,
                           already_posted: false)

    login_as(admin)
    visit root_path
    click_on 'Vendas Pendentes'
    click_on order.id
    click_on 'Reenviar pedido'

    expect(page).to have_content('Pedido criado com sucesso')
  end

  scenario 'and only see not sent orders in pending list' do
    admin = create(:seller, admin: true)
    seller = create(:seller, email: 'user@email.com')
    customer = create(:customer, :legal)
    order = create(:order, customer: customer,
                           seller: seller,
                           ready: true,
                           already_posted: true,
                           product_name: 'Hospedagem')

    login_as(admin)
    visit root_path
    click_on 'Vendas Pendentes'

    expect(page).not_to have_link(order.product_name)
  end

  scenario 'and only see button resend in not sent orders' do
    admin = create(:seller, admin: true)
    seller = create(:seller, email: 'user@email.com')
    customer = create(:customer, :legal)
    order = create(:order, customer: customer,
                           seller: seller,
                           ready: true,
                           already_posted: true,
                           product_name: 'Hospedagem')

    login_as(admin)
    visit root_path
    click_on 'Vendas'
    click_on order.id

    expect(page).not_to have_link('Reenviar pedido')
  end
end
