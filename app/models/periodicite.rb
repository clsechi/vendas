class Periodicite

  attr_accessor :price, :period

  def initialize(params)
    @price = params["price"]
    @period = params["period"]
  end

  def name
    if @period == 1
      "#{@period} mês - R$ #{@price}"
    else
      "#{@period} meses - #{@price}"
    end
  end
end
