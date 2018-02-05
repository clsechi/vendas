class Plan

  attr_accessor :id, :name, :periodicites

  def initialize(params)
    @periodicites = params["periodicites"]
    @id = params["id"]
    @name = params["name"]
  end

  def periodicites
    periodicite = []
    @periodicites.each do |per|
      periodicite << Periodicite.new(per)
    end
    periodicite
  end
end
