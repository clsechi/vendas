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
      redirect_to customer_order_products_path(@order.customer, @order)
    else
      @categories = get_categories
      render :new
    end
  end

  #lista todos os produtos
  def list_products
    @products = get_products
  end

  # salva id do produto
  def set_product
    @order = Order.find(params[:order_id])
    prod_id = params[:product_id]
    set_session('product_name', params[:product_name])
    if @order.update(product_id: prod_id)
      redirect_to customer_order_plans_path(@order.customer, @order)
    else
      @products = get_products
      render :products
    end
  end

  def list_plans
    @plans = get_plans
  end

  def set_plan
    @order = Order.find(params[:order_id])
    pl_id = params[:plan_id]
    set_session('plan_name', params[:plan_name])
    if @order.update(plan_id: pl_id)
      redirect_to customer_order_prices_path(@order.customer, @order)
    else
      @plans = get_plans
      render :plans
    end
  end

  def list_prices
    @order = Order.find(params[:order_id])
    @customer = @order.customer
    @prices = get_prices
  end

  def set_price
    @order = Order.find(params[:order_id])
    price_id = params[:value]
    @order.periodicity_id = params[:periodicity_id]
    set_session('price_name', params[:price_name])
    if @order.update(value: price_id)
      redirect_to customer_order_check_path(@order.customer, @order)
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

    uri = URI('http://localhost:3001/api/categories')
    categories_json = Net::HTTP.get(uri)
    #categories_json = '{"categories":[{"id": 1,"name": "Hospedagem"}, {"id": 2,"name": "Cloud e Servidores"},{"id": 3,"name": "Loja Virtual"}]}'
    categories_hash = JSON.parse(categories_json)

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
      "periodicity":{
         "id":1,
         "name":"Mensal",
         "period":1
      }
   },
   {
      "id":2,
      "value":40,
      "periodicity":{
            "id":2,
            "name":"Trimestral",
            "period":3
         }
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
