require 'rails_helper'

RSpec.describe OrdersSenderService do
  WebMock.allow_net_connect!
  describe 'api send order JSON' do
    it 'send JSON' do
      seller = create(:seller)
      customer = create(:customer, :legal)
      order = create(:order, seller: seller, customer: customer)

      login_as seller
      body = { 'order': order.to_json, 'customer': order.customer.to_json }
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

    it 'and raise a server error' do
      seller = create(:seller)
      customer = create(:customer, :legal)
      order = create(:order, seller: seller, customer: customer)

      login_as seller
      body = { 'order': order.to_json, 'customer': order.customer.to_json }
      url = "#{Rails.configuration.sales['client_panel_url']}"\
            "#{Rails.configuration.sales['send_order']}"

      stub_request(:post, url)
        .with(
          body: body
        ).to_return(status: 500, body: '', headers: {})

      expect { OrdersSenderService::OrdersService.send_post(order) }
        .to raise_error(StandardError)
      expect(a_request(:post, url)).to have_been_made.at_least_once
    end
  end
end
