require 'rails_helper'

feature 'Admin cancel order' do
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

    expect(page).to have_link('Cancelar venda')
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

  scenario 'and can cancel the order at any time' do
    admin = create(:seller, admin: true)
    seller = create(:seller, email: 'user@email.com')
    customer = create(:customer, :legal)
    order = create(:order, customer: customer,
                           seller: seller,
                           ready: false,
                           already_posted: false)

    login_as(admin)
    visit root_path
    click_on 'Vendas Pendentes'
    click_on order.id

    expect(page).to have_link('Cancelar venda')
  end
end
