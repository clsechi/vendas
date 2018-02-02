require 'rails_helper'

RSpec.describe OrdersSenderService do
  describe 'api send order JSON' do
    it 'send JSON' do
        seller = create(:seller)
        customer = create(:customer, :legal)
        order = create(:order, seller: seller, customer: customer)

        login_as seller
        #post_order = OrdersSenderService::OrdersService.send_post(order)
        body = order.to_json

        stub_request(:post, 'http://06162072-025d-475c-883f-eb3a7407ffe6.mock.pstmn.io/orders/new/:80/').
           with(
             body: body,
             headers: {
         	  'Accept'=>'*/*',
         	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         	  'Content-Length'=>'3',
         	  'User-Agent'=>'Ruby'
             }).
           to_return(status: 200, body: "", headers: {})


          #Actual request
          req = Net::HTTP::Post.new('/')
          req['Content-Length'] = 3
          Net::HTTP.start('06162072-025d-475c-883f-eb3a7407ffe6.mock.pstmn.io/orders/new/') {|http|
              http.request(req, body)
          }

          expect(a_request(:post, 'http://06162072-025d-475c-883f-eb3a7407ffe6.mock.pstmn.io/orders/new/:80/')).to have_been_made.at_least_once

    end
  end
end

