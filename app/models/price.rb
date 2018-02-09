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
end
