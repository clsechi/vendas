class Periodicity
  attr_accessor :id, :name, :period

  def initialize(params)
    @id = params['id']
    @name = params['name']
    @period = params['period']
  end
end
