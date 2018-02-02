module OrdersSenderService
  class OrdersService
    include HTTParty
    #base_uri 'painel.cliente.com'
    base_uri 'https://06162072-025d-475c-883f-eb3a7407ffe6.mock.pstmn.io'

    def initialize
    end

    def self.send_post(order)
      body = order.to_json
      options = { :body => body }

      self.post("/orders/new", options)

      # uri = URI('https://06162072-025d-475c-883f-eb3a7407ffe6/orders/new)
      #  res = Net::HTTP.post_form(uri, 'body' => body)
      #  puts res.body
    end
  end
end