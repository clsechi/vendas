class Periodicite

  attr_accessor :name, :period

  def initialize(params)
    @name = params["name"]
    @period = params["period"]
  end
end
