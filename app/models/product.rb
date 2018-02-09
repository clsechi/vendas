class Product
  attr_accessor :id, :name, :description

  def initialize(params)
    @id = params['id']
    @name = params['name']
    @description = params['description']
  end
end
