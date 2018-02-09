class Plan
  attr_accessor :id, :name, :description

  def initialize(params)
    @id = params['id']
    @name = params['name']
    @description = params['description']
  end

  def self.all(order)
    uri = URI "#{Rails.configuration.sales['products_url']}/products/#{order
                      .product_id}/product_plans"
    plans_json = Net::HTTP.get(uri)
    plans_hash = JSON.parse(plans_json)
    plans_hash['plans'].map { |plan| Plan.new plan }
  end
end
