require 'rails_helper'

feature 'seller views your orders' do
  scenario 'successfully' do
    seller = create(:seller)
    other_seller = create(:seller, email: 'teste321@teste.com')
    customer = create(:customer)
    order = create(:order, customer: customer, seller: seller)
    other_order = create(:order, customer: customer, seller: other_seller)

    login_as(seller)

    visit root_path

    click_on 'Visualizar meus pedidos'

    expect(page).to have_link(order.id)
    expect(page).not_to have_link(other_order.id)
  end

  scenario 'and view multiples orders' do
    seller = create(:seller)
    another_seller = create(:seller, email: 'teste321@teste.com')
    customer = create(:customer)
    order = create(:order, customer: customer, seller: seller)
    other_order = create(:order, customer: customer, seller: seller)
    another_order = create(:order, customer: customer, seller: another_seller)

    login_as(seller)

    visit root_path

    click_on 'Visualizar meus pedidos'

    expect(page).to have_link(order.id)
    expect(page).to have_link(other_order.id)
    expect(page).not_to have_link(another_order.id)
  end
end
