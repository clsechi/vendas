require 'rails_helper'

feature 'seller create order' do
  scenario 'with category' do
    customer = create(:customer, :legal)
    seller = create(:seller)

    login_as(seller)
    visit new_customer_order_path(customer)
    click_on 'Hospedagem'

    expect(page).to have_content('Categoria: Hospedagem')
    expect(page).to have_content('Selecione o produto')
  end

  scenario 'with category and product' do
    customer = create(:customer, :legal)
    seller = create(:seller)

    login_as(seller)
    visit new_customer_order_path(customer)
    click_on 'Hospedagem'
    click_on 'Hospedagem de sites'

    expect(page).to have_content('Selecione o plano')
    expect(page).to have_content('Categoria: Hospedagem')
    expect(page).to have_content('Produto: Hospedagem de sites')

  end

  scenario 'with category, product and plan' do
    customer = create(:customer, :legal)
    seller = create(:seller)

    login_as(seller)
    visit new_customer_order_path(customer)
    click_on 'Hospedagem'
    click_on 'Hospedagem de sites'
    click_on 'Hospedagem I'

    expect(page).to have_content('Categoria: Hospedagem')
    expect(page).to have_content('Produto: Hospedagem de sites')
    expect(page).to have_content('Plano: Hospedagem I')
  end


end
