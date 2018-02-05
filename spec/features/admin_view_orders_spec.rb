require 'rails_helper'

feature 'user views orders list' do
  scenario 'successfully' do
    admin = create(:seller, email: 'admin@email.com', admin: true)
    seller = create(:seller)
    customer = create(:customer, :legal)
    order = create(:order, customer: customer, seller: seller)

    login_as(admin)

    visit root_path

    click_on 'Visualizar todos pedidos'

    expect(page).to have_link(order.id)
  end

  scenario 'and admin views all orders' do
    admin = create(:seller, email: 'admin@email.com', admin: true)
    seller = create(:seller)
    customer = create(:customer, :legal)
    order = create(:order, customer: customer, seller: seller)

    login_as(admin)

    visit root_path

    click_on 'Visualizar todos pedidos'

    expect(page).to have_link(order.id)
  end

  scenario 'and other users cant see' do
    seller = create(:seller)
    customer = create(:customer, :legal)
    create(:order, customer: customer, seller: seller)

    login_as(seller)

    visit root_path

    expect(page).not_to have_link('Visualizar todos pedidos')
  end

  scenario 'and admin views order owner' do
    admin = create(:seller, email: 'admin@email.com', admin: true)
    seller = create(:seller)
    customer = create(:customer, :legal)
    order = create(:order, customer: customer, seller: seller)

    login_as(admin)

    visit root_path

    click_on 'Visualizar todos pedidos'

    expect(page).to have_link(order.id)
    expect(page).to have_content(order.seller.email)
  end
end
