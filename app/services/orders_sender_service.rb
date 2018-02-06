module OrdersSenderService
  class OrdersService
    include HTTParty
    base_uri 'https://06162072.mock.pstmn.io'

    def self.send_post(order)
      options = { 'body': order.to_json, 'customer': order.customer.to_json }
      response = post('/orders', options)

      unless response.success?
        raise StandardError, 'Erro interno no envio para API'
      end
      true
    end
  end
end
