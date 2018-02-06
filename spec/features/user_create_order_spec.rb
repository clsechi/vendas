require 'rails_helper'

feature 'user create order' do
  scenario 'sucessfully' do
    create(:customer, :legal)
    seller = create(:seller)

    login_as(seller)
    visit new_order_path
    page.select 'Hospedagem', from: 'Categoria'
    expect(OrdersSenderService::OrdersService).to receive(:send_post)
    click_on 'Criar pedido'

    expect(page).to have_content('Pedido criado com sucesso, mas não enviado')
    expect(page).to have_content('Categoria: 1')
  end
end
