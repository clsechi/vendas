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

  scenario 'and can cancel with empty periodicity field' do
    admin = create(:seller, admin: true)
    seller = create(:seller, email: 'user@email.com')
    customer = create(:customer, :legal)
    order = create(:order, customer: customer,
                           seller: seller,
                           product_id: 1,
                           category_id: 1,
                           plan_id: 1,
                           value: 40.0,
                           periodicity_id: nil,
                           ready: false,
                           already_posted: false)

    login_as(admin)
    visit root_path
    click_on 'Vendas Pendentes'
    click_on order.id

    expect(page).to have_link('Cancelar venda')
  end

  scenario 'and can cancel with empty value field' do
    admin = create(:seller, admin: true)
    seller = create(:seller, email: 'user@email.com')
    customer = create(:customer, :legal)
    order = create(:order, customer: customer,
                           seller: seller,
                           product_id: 1,
                           category_id: 1,
                           plan_id: 1,
                           value: nil,
                           periodicity_id: nil,
                           ready: false,
                           already_posted: false)

    login_as(admin)
    visit root_path
    click_on 'Vendas Pendentes'
    click_on order.id

    expect(page).to have_link('Cancelar venda')
  end

  scenario 'and can cancel with empty plan field' do
    admin = create(:seller, admin: true)
    seller = create(:seller, email: 'user@email.com')
    customer = create(:customer, :legal)
    order = create(:order, customer: customer,
                           seller: seller,
                           product_id: 1,
                           category_id: 1,
                           plan_id: nil,
                           value: nil,
                           periodicity_id: nil,
                           ready: false,
                           already_posted: false)

    login_as(admin)
    visit root_path
    click_on 'Vendas Pendentes'
    click_on order.id

    expect(page).to have_link('Cancelar venda')
  end

  scenario 'and can cancel with empty product field' do
    admin = create(:seller, admin: true)
    seller = create(:seller, email: 'user@email.com')
    customer = create(:customer, :legal)
    order = create(:order, customer: customer,
                           seller: seller,
                           product_id: nil,
                           category_id: 1,
                           plan_id: nil,
                           value: nil,
                           periodicity_id: nil,
                           ready: false,
                           already_posted: false)

    login_as(admin)
    visit root_path
    click_on 'Vendas Pendentes'
    click_on order.id

    expect(page).to have_link('Cancelar venda')
  end
end
