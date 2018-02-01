require 'rails_helper'

feature 'seller chooses category and product' do
  scenario 'sucessfully' do
    customer = create(:customer)
    seller = create(:seller)

    login_as(seller)
    visit new_customer_order_path(customer)
    page.choose 'Hospedagem'
    #colocar sleep para esperar a requisição
    #page.select 'Hospedagem de sites', from: 'Produto'
    click_on 'Próximo'

    expect(page).to have_css('h1', text: 'Selecione o Produto')
  end
end
