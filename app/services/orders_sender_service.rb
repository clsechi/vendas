module OrdersSenderService
  class OrdersService
    include HTTParty
    base_uri Rails.configuration.sales['host']

    def self.send_post(order)
      options = { 'body': order.to_json, 'customer': order.customer.to_json }
      response = post(Rails.configuration.sales['send_order'], options)

      unless response.success?
        raise StandardError, 'Erro interno no envio para API'
      end
      true
    end
  end
end
