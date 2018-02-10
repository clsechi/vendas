class Product
  attr_accessor :id, :name

  def initialize(params)
    @id = params['id']
    @name = params['name']
  end

  def self.all(order)
    uri = URI "#{Rails.configuration.sales['products_url']}/categories/#{order
                      .category_id}/products"
    products_json = Net::HTTP.get(uri)
    products_hash = JSON.parse(products_json)
    products_hash['products'].map { |product| Product.new(product) }
  end
end
