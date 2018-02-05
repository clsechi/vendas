require 'rails_helper'

RSpec.describe OrdersSenderService do
  describe 'api send order JSON' do
    it 'send JSON' do
      seller = create(:seller)
      customer = create(:customer, :legal)
      order = create(:order, seller: seller, customer: customer)

      login_as seller
      body = order.to_json
      url = 'https://06162072.mock.pstmn.io/orders'

      stub_request(:post, url).
         with(
           body: body,
           headers: {
         	  'Accept'=>'*/*',
         	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         	  'User-Agent'=>'Ruby'
           }).to_return(status: 200, body: '', headers: {})

      response = OrdersSenderService::OrdersService.send_post(order)

      expect(a_request(:post, url)).to have_been_made.at_least_once
      expect(response).to eq(true)
    end

    it 'and raise a server error' do
      seller = create(:seller)
      customer = create(:customer, :legal)
      order = create(:order, seller: seller, customer: customer)

      login_as seller
      body = order.to_json
      url = 'https://06162072.mock.pstmn.io/orders'

      stub_request(:post, url).
         with(
           body: body,
           headers: {
         	  'Accept'=>'*/*',
         	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         	  'User-Agent'=>'Ruby'
           }).to_return(status: 500, body: '', headers: {})

      expect {  OrdersSenderService::OrdersService.send_post(order) }.to raise_error(StandardError)
      expect(a_request(:post, url)).to have_been_made.at_least_once
    end
  end
end
