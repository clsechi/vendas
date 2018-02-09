require 'rails_helper'

feature 'seller create order' do
  scenario 'view categories available' do
    stub_request_categories
    stub_request_products

    customer = create(:customer, :legal)
    seller = create(:seller)

    login_as(seller)
    visit new_customer_order_path(customer)

    click_on 'Hospedagem'

    expect(page).to have_content('Categoria: Hospedagem')
    expect(page).to have_content('Selecione o produto')
  end

  scenario 'with category and product' do
    stub_request_categories
    stub_request_products
    stub_request_plans
    customer = create(:customer, :legal)
    seller = create(:seller)

    login_as(seller)
    visit new_customer_order_path(customer)
    click_on 'Hospedagem'
    click_on 'Hospedagem'

    expect(page).to have_content('Selecione o plano')
    expect(page).to have_content('Categoria: Hospedagem')
    expect(page).to have_content('Produto: Hospedagem')
  end

  scenario 'with category, product and plan' do
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

    expect(page).to have_content('Categoria: Hospedagem')
    expect(page).to have_content('Produto: Hospedagem')
    expect(page).to have_content('Plano: Hospedagem I')
    expect(page).to have_content('Selecione a periodicidade')
  end

  scenario 'with category, product, plan and periodicity' do
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

    expect(page).to have_css('h5', text: 'Pedido')
    expect(page).to have_content('Categoria: Hospedagem')
    expect(page).to have_content('Produto: Hospedagem')
    expect(page).to have_content('Plano: Hospedagem I')
    expect(page).to have_content('Periodicidade: Anual - R$ 19.9')
    expect(page).to have_button('Confirmar')
  end
end
