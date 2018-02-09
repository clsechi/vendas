require 'rails_helper'

feature 'seller delete order' do
  scenario 'cancel in category page' do
    stub_request_categories
    stub_request_products

    customer = create(:customer, :legal)
    seller = create(:seller)

    login_as(seller)
    visit new_customer_order_path(customer)

    click_on 'Hospedagem'
    click_on 'Cancelar venda'

    expect(page).to have_content('Venda cancelada!')
  end

  scenario 'cancel in product page' do
    stub_request_categories
    stub_request_products
    stub_request_plans

    customer = create(:customer, :legal)
    seller = create(:seller)

    login_as(seller)
    visit new_customer_order_path(customer)

    click_on 'Hospedagem'
    click_on 'Hospedagem'
    click_on 'Cancelar venda'

    expect(page).to have_content('Venda cancelada!')
  end

  scenario 'cancel in plan page' do
    stub_request_categories
    stub_request_products
    stub_request_plans
    stub_request_prices

    customer = create(:customer, :legal)
    seller = create(:seller)

    login_as(seller)
    visit new_customer_order_path(customer)

    click_on 'Hospedagem'
    click_on 'Hospedagem'
    click_on 'Hospedagem I'
    click_on 'Cancelar venda'

    expect(page).to have_content('Venda cancelada!')
  end

  scenario 'cancel in price/periodicity page' do
    stub_request_categories
    stub_request_products
    stub_request_plans
    stub_request_prices

    customer = create(:customer, :legal)
    seller = create(:seller)

    login_as(seller)
    visit new_customer_order_path(customer)

    click_on 'Hospedagem'
    click_on 'Hospedagem'
    click_on 'Hospedagem I'
    click_on 'Anual - R$ 19.9'
    click_on 'Cancelar venda'

    expect(page).to have_content('Venda cancelada!')
  end
end
