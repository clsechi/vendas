require 'rails_helper'

feature 'Admin resend order' do
  WebMock.allow_net_connect!
  scenario 'successfully' do
    admin = create(:seller, admin: true)
    seller = create(:seller, email: 'user@email.com')
    customer = create(:customer, :legal)
    order = create(:order, customer: customer,
                           seller: seller,
                           ready: true,
                           already_posted: false)

    login_as(admin)
    visit root_path
    click_on 'Vendas Pendentes'
    click_on order.id
    click_on 'Reenviar pedido'
    body = { order: order, customer: order.customer }.to_json
    url = "#{Rails.configuration.sales['client_panel_url']}"\
          "#{Rails.configuration.sales['send_order']}"

    stub_request(:post, url)
      .with(
        body: body
      ).to_return(status: 200, body: '', headers: {})

    response = OrdersSenderService::OrdersService.send_post(order)

    expect(a_request(:post, url)).to have_been_made.at_least_once
    expect(response).to eq(true)
  end

  scenario 'and only see not sent orders in pending list' do
    admin = create(:seller, admin: true)
    seller = create(:seller, email: 'user@email.com')
    customer = create(:customer, :legal)
    order = create(:order, customer: customer,
                           seller: seller,
                           ready: true,
                           already_posted: true,
                           product_name: 'Hospedagem')

    login_as(admin)
    visit root_path
    click_on 'Vendas Pendentes'

    expect(page).not_to have_link(order.product_name)
  end

  scenario 'and only see button resend in not sent orders' do
    admin = create(:seller, admin: true)
    seller = create(:seller, email: 'user@email.com')
    customer = create(:customer, :legal)
    order = create(:order, customer: customer,
                           seller: seller,
                           ready: true,
                           already_posted: true,
                           product_name: 'Hospedagem')

    login_as(admin)
    visit root_path
    click_on 'Vendas'
    click_on order.id

    expect(page).not_to have_link('Reenviar pedido')
  end
end
