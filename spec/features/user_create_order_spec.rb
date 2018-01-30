require 'rails_helper'

feature 'user create order' do
  scenario 'sucessfully' do
      seller = create(:seller)

      login_as(seller)
      visit new_order_path
      page.select 'Hospedagem', from: 'Produtos'
      page.select '3 meses', from: 'Periodicidade'
      click_on 'Criar pedido'

      expect(page).to have_content('Pedido criado com sucesso!')
      expect(current_path).to eq(client_orders_path)
      expect(page).to have_content('Produto: Hospedagem')
      expect(page).to have_content('Periodicidade: 3 meses')
  end
end
