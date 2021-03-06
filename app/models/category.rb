class Category
  attr_accessor :id, :name, :description

  def initialize(params)
    @id = params['id']
    @name = params['name']
    @description = params['description']
  end

  def self.all
    uri = URI "#{Rails.configuration.sales['products_url']}/categories"
    categories_json = Net::HTTP.get(uri)
    categories_hash = JSON.parse(categories_json)
    categories_hash['categories'].map { |category| Category.new category }
  end
end
