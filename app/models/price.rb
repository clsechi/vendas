class Price

  attr_accessor :value, :periodicites

  def initialize(params)
    @value = params["value"]
    @periodicites = params["periodicites"]
  end

  def periodicites
    periodicite = Periodicite.new(@periodicite)
  end

  # def find_price(period)
  #   price = ''
  #   periodicites.each do |p|
  #     if p.period == period
  #       price = p.price
  #     end
  #   end
  #   price
  # end

end
