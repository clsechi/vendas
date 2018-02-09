module OrdersSenderService
  class OrdersService
    include HTTParty
    base_uri Rails.configuration.sales['client_panel_url']

    def self.send_post(order)
      options = { 'body':
                      { 'order': order.to_json,
                        'customer': order.customer.to_json } }
      response = post(Rails.configuration.sales['send_order'], options)

      unless response.success?
        raise StandardError, 'Erro interno no envio para API'
      end
      true
    end
  end
end
