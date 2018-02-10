class Price
  attr_accessor :value, :periodicity

  def initialize(params)
    @value = params['value']
    @periodicity = params['periodicity']
  end

  def per
    Periodicity.new(@periodicity)
  end

  def name
    "#{per.name} - R$ #{@value}"
  end

  def self.all(order)
    uri = URI "#{Rails.configuration
                      .sales['products_url']}/product_plans/#{order
                      .plan_id}/plan_prices"
    prices_json = Net::HTTP.get(uri)
    prices_hash = JSON.parse(prices_json)
    prices_hash['prices'].map { |price| Price.new price }
  end
end
