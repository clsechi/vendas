require 'rails_helper'

RSpec.describe OrdersSenderService do
  describe 'api send order JSON' do
    it 'send JSON' do
        seller = create(:seller)
        customer = create(:customer, :legal)
        order = create(:order, seller: seller, customer: :customer)

        login_as seller
        post_order = OrdersSenderService::OrdersService.send_post(order)

        #expect(post_order).to eq()


    end
  end
end

