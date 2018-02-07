require 'rails_helper'

feature 'user create order' do
  scenario 'sucessfully' do
    customer = create(:customer, :legal)
    seller = create(:seller)

    login_as(seller)
    visit new_customer_order_path(customer)
    click_on 'Hospedagem'
    expect(OrdersSenderService::OrdersService).to receive(:send_post)
    click_on 'Criar pedido'

    expect(page).to have_content('Pedido criado com sucesso, mas não enviado')
    expect(page).to have_content('Categoria: 1')
  end

  scenario 'and system sends email' do
    customer = create(:customer, :legal)
    seller = create(:seller)

    login_as(seller)
    visit new_customer_order_path(customer)
    click_on 'Hospedagem'
    expect(OrdersSenderService::OrdersService).to receive(:send_post)
    click_on 'Criar pedido'

    mail = ActionMailer::Base.deliveries.last
    expect(mail.subject).to eq 'Pedido realizado com sucesso'
    expect(mail.from).to include 'no-reply@locaweb.com.br'
  end
end
