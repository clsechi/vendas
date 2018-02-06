class OrdersController < ApplicationController
  before_action :authenticate_seller!, only: [:index, :new, :create, :show]
  def index
    if current_seller.admin?
      @orders = Order.all
    else
      @orders = Order.where(seller_id: current_seller)
    end
  end

  def new
    @categories = get_categories
  end

  def create
    @order = Order.new
    @order.customer_id = params[:customer_id]
    @order.category_id = params[:category_id]
    set_session('category_name', params[:category_name])
    @order.seller_id = current_seller.id
    if @order.save
      redirect_to customer_order_products_path(@order.customer_id, @order.id,
        @order.category_id)
    else
      @categories = get_categories
      render :new
    end
  end

  #lista todos os produtos
  def products
    @products = get_products
  end

  # salva id do produto
  def product
    @order = Order.find(params[:order_id])
    prod_id = params[:product_id]
    set_session('product_name', params[:product_name])
    if @order.update(product_id: prod_id)
      redirect_to customer_order_plans_path(@order.customer_id, @order.category_id, @order.id, @order.product_id)
    else
      @products = get_products
      render :products
    end
  end

  def plans
    @plans = get_plans
  end

  def plan
    @order = Order.find(params[:order_id])
    pp @order
    pl_id = params[:plan_id]
    set_session('plan_name', params[:plan_name])
    pp pl_id
    if @order.update(plan_id: pl_id)
      pp @order
      redirect_to customer_order_prices_path(@order.customer_id, @order.category_id,
         @order.id, @order.product_id, @order.plan_id)
    else
      @plans = get_plans
      render :plans
    end
  end

  def prices
    @prices = get_prices
  end

  def set_prices
    @order = Order.find(params[:order_id])
    @order.price = params(:price)
    @order.periodicite = params(:periodicite)
    #set_session('per_name', @prices.periodicite.name)
    if @order.update
      redirect_to customer_order_check_path(@order.customer_id, @order.category_id,
         @order.id, @order.product_id, @order.plan_id)
    else
      @prices = get_prices
      render :prices
    end
  end

  def check
    @order = Order.find(params[:order_id])
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def set_session(session_name, session_value)
    session_name = session_name.to_sym
    session[session_name] = session_value
  end

  def get_categories

    #uri = URI('http://localhost:3001/api/categories')
    #categories_json = Net::HTTP.get(uri)
    #categories_json = '[{"id": 1,"name": "Hospedagem"}, {"id": 2,"name": "Cloud e Servidores"},{"id": 3,"name": "Loja Virtual"} ]'
    categories_hash = JSON.parse(categories_json)

    pp categories_hash

    categories = []

    categories_hash['categories'].each do |category|
      categories << Category.new(category)
    end
    categories
  end

  def get_products
    products_json = '{"products":[{"id": 1, "name": "Hospedagem de sites"}, {"id": 2, "name": "Registro de dominios"},
     {"id": 3, "name": "SSL de Locaweb"}]}'
    products_hash = JSON.parse(products_json)

    products = []

    products_hash['products'].each do |product|
      products << Product.new(product)
    end
    products
  end

  def get_plans
    plans_json = '[{"id": 1, "name": "Hospedagem I", "description": "some text"},
                    {"id": 2, "name": "Hospedagem II", "description": "some text"},
                    {"id": 3, "name": "Hospedagem III", "description": "some text"}]'

    plans_hash = JSON.parse(plans_json)
    plans = []

    plans_hash.each do |plan|
      plans << Plan.new(plan)
    end
    plans
  end

  def get_prices
    prices_json = '[
   {
      "id":1,
      "value":20,
      "periodicite":
         {
            "name":"Mensal",
            "period":1
         }
      
   },
   {
      "id":2,
      "value":40,
      "periodicite":[
         {
            "name":"Trimestral",
            "period":3
         }
      ]
   }
]'

    prices_hash = JSON.parse(prices_json)
    prices = []

    prices_hash.each do |price|
      prices << Price.new(price)
    end
    prices
  end
end
