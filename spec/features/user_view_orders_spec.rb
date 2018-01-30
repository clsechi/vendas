require 'rails_helper'

feature 'user views orders list' do
  scenario 'successfully' do
    seller = create(:seller, admin: true)
    customer = create(:customer)
    order = create(:order, customer: customer)

    login_as(seller)

    visit root_path

    click_on 'Visualizar todos pedidos'

    expect(page).to have_link(order.id)
  end

  scenario 'and admin views all orders' do
    seller = create(:seller, admin: true)
    customer = create(:customer)
    order = create(:order, customer: customer)

    login_as(seller)

    visit root_path

    click_on 'Visualizar todos pedidos'

    expect(page).to have_link(order.id)
  end

  scenario 'and other users cant see' do
    seller = create(:seller)
    customer = create(:customer)
    order = create(:order, customer: customer)

    login_as(seller)

    visit root_path

    expect(page).not_to have_link('Visualizar todos pedidos')
  end
end
