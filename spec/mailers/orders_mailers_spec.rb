require 'rails_helper'

RSpec.describe OrderMailer do
  describe 'share' do
    it 'Send email correctly with all parameters' do
      seller = create(:seller)
      customer = create(:customer, :legal)
      order = create(:order, seller: seller, customer: customer)

      name = order.customer.name
      email = order.customer.email

      mail = OrderMailer.order_email(order)

      expect(mail.to).to include email
      expect(mail.subject).to eq 'Pedido realizado com sucesso'
      expect(mail.from).to include 'no-reply@locaweb.com.br'
      expect(mail.body).to include name
      expect(mail.body).to include "Seu pedido #{order.id} foi realizado "\
                                   'com sucesso.'
    end
  end
end
