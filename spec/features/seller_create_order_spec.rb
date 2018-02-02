require 'rails_helper'

feature 'seller create order' do
  scenario 'with category' do
    customer = create(:customer)
    seller = create(:seller)

    login_as(seller)
    visit new_customer_order_path(customer)
    page.choose 'Hospedagem'
    click_on 'Próximo'
    #expect
    expect(page).to have_content('Selecionar produto')
  end

  scenario 'with category and product' do
    customer = create(:customer)
    seller = create(:seller)

    login_as(seller)
    visit new_customer_order_path(customer)
    page.choose 'Hospedagem'
    click_on 'Próximo'
    page.choose 'Hospedagem de Sites'
    click_on 'Próximo'

    #expect
    expect(page).to have_content('Selecionar plano')

  end

  scenario 'with category, product and plan' do
    customer = create(:customer)
    seller = create(:seller)

    login_as(seller)
    visit new_customer_order_path(customer)
    page.choose 'Hospedagem'
    click_on 'Próximo'
    page.choose 'Hospedagem de Sites'
    click_on 'Próximo'
    page.choose 'Hospedagem I'
    page.choose 'Anual'
    click_on 'Próximo'

    expect(page).to have_css('h1', text:'Pedido')
    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('Hospedagem de sites')
    expect(page).to have_content('Hospedagem I')
    expect(page).to have_content('Anual')
    expect(page).to have_link('Finalizar pedido')
    expect(page).not_to have_link('Próximo')
  end
end
