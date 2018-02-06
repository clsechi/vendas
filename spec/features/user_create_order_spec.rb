require 'rails_helper'

feature 'user create order' do
  scenario 'sucessfully' do
    create(:customer, :legal)
    seller = create(:seller)

    login_as(seller)
    visit new_order_path
    page.select 'Hospedagem', from: 'Categoria'
    # page.select 'Hospedagem de sites', from: 'Produto'
    # page.select 'Hospedagem I', from: 'Plano'
    # page.select 'Trimestral', from: 'Periodicidade'
    click_on 'Criar pedido'

    expect(page).to have_content('Pedido criado com sucesso!')
    # expect(current_path).to eq(client_orders_path)
    expect(page).to have_content('Categoria: 1')
    # expect(page).to have_content('Periodicidade: 3 meses')
  end

  scenario 'and system sends email' do
    seller = create(:seller)

    login_as(seller)
    visit new_order_path
    page.select 'Hospedagem', from: 'Categoria'
    click_on 'Criar pedido'

    mail = ActionMailer::Base.deliveries.last
    expect(mail.subject).to eq 'Pedido realizado com sucesso'
    expect(mail.from).to include 'no-reply@locaweb.com.br'
  end
end
