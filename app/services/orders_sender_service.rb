module OrdersSenderService
  class OrdersService
    include HTTParty
    base_uri Rails.configuration.sales['client_panel_url']

    def self.send_post(order)
      params = { order: order, customer: order.customer }.to_json
      response = post Rails.configuration.sales['send_order'],
                      body: params,
                      headers: { 'Content-Type': 'application/json' }

      unless response.success?
        raise StandardError, 'Erro interno no envio para API'
      end
      true
    end
  end
end
