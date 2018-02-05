module ApiFunctions
  def parse_json
    JSON.parse(response.body, symbolize_names: true)
  end

  def url_order
    '/api/orders'
  end
end
