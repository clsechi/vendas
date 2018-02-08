module ApiFunctions
  def stub_request_categories
    stub_request(:get, 'http://localhost:3001/api/categories')
      .to_return(body: '{"categories":[{"id":1,"name":"Hospedagem","description":"Hospedagem ilimitada"}]}')
  end

  def stub_request_products
    stub_request(:get, 'http://localhost:3001/api/categories/1/products')
      .to_return(body: '{"categories":{"id":"1"},"products":[{"id":1,"name":"Hospedagem","description":"Hospedagem ilimitada","product_key":"HOSP123","product_category_id":1,"contract":"contrato123"}]}')
  end

  def stub_request_plans
    stub_request(:get, 'http://localhost:3001/api/products/1/product_plans')
      .to_return(body: '{"products":{"id":"1"},"plans":[{"id":1,"product_id":1,"name":"Hospedagem I"}]}')
  end
end
