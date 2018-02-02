class OrderSenderService
  include HTTParty
  #base_uri 'painel.cliente.com'
  base_uri 'https://06162072-025d-475c-883f-eb3a7407ffe6.mock.pstmn.io'

  def send_post(order)
    body = order.to_json
    options = { :body => body }
    self.class.post('/orders/new', options)
  end
end
