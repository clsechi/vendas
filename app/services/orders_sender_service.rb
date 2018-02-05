module OrdersSenderService
  class OrdersService
    include HTTParty
    #base_uri 'painel.cliente.com'
    base_uri 'https://06162072.mock.pstmn.io'

    def self.send_post(order)
      options = { 'body': order.to_json }
      response = self.post('/orders', options)

      if response.success?
        return true
      else
        raise StandardError, 'Erro interno no envio para API'
      end
    end

  end
end
