require 'rails_helper'

feature 'seller create order' do
  scenario 'with category' do
    customer = create(:customer, :legal)
    seller = create(:seller)

    login_as(seller)
    visit new_customer_order_path(customer)
    click_on 'Hospedagem'
    #expect
    expect(page).to have_content('Selecione o produto')
  end

  scenario 'with category and product' do
    customer = create(:customer, :legal)
    seller = create(:seller)

    login_as(seller)
    visit new_customer_order_path(customer)
    click_on 'Hospedagem'
    click_on 'Hospedagem de sites'

    #expect
    expect(page).to have_content('Selecione o plano')

  end

  scenario 'with category, product and plan' do
    customer = create(:customer, :legal)
    seller = create(:seller)

    login_as(seller)
    visit new_customer_order_path(customer)
    click_on 'Hospedagem'
    click_on 'Hospedagem de sites'
    click_on 'Hospedagem I'

    expect(page).to have_css('h1', text:'Pedido')
    # expect(page).to have_content('Hospedagem')
    # expect(page).to have_content('Hospedagem de sites')
    # expect(page).to have_content('Hospedagem I')
    # #expect(page).to have_content('Anual')
    # expect(page).to have_link('Finalizar pedido')
    # expect(page).not_to have_link('Próximo')
  end
end
