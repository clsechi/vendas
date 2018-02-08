class OrdersController < ApplicationController
  before_action :authenticate_seller!, only: [:index, :new, :create, :show]

  def index
    @orders = if current_seller.admin?
                Order.all
              else
                Order.where(seller_id: current_seller)
              end
  end

  def new
    uri = URI('http://localhost:3001/api/categories')
    categories_json = Net::HTTP.get(uri)
    categories_hash = JSON.parse(categories_json)
    @categories = categories_hash['categories'].map { |category| Category.new category }
  end

  def create
    @order = Order.new
    @order.customer_id = params[:customer_id]
    @order.category_id = params[:category_id]
    set_session('category_name', params[:category_name])

    @order.seller_id = current_seller.id
    if @order.save
      send_email(@order.id)
      # send_order
      redirect_to customer_order_products_path(@order.customer, @order)
    else
      render :new
    end
  end

  #lista todos os produtos
  def list_products
    order = Order.find(params[:order_id])
    uri = URI "http://localhost:3001/api/categories/#{order.category_id}/products"
    products_json = Net::HTTP.get(uri)
    products_hash = JSON.parse(products_json)
    @products = products_hash['products'].map { |product| Product.new product }
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
    order = Order.find(params[:order_id])
    uri = URI "http://localhost:3001/api/products/#{order.product_id}/product_plans"
    plans_json = Net::HTTP.get(uri)
    plans_hash = JSON.parse(plans_json)
    @plans = plans_hash['plans'].map { |plan| Plan.new(plan) }
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

    prices_hash.map { |price| Price.new price }
  end

  def send_email(order_id)
    order = Order.find(order_id)
    OrderMailer.order_email(order).deliver_now
  end

  def send_order
    flash[:notice] = if OrdersSenderService::OrdersService.send_post(@order)
                       'Pedido criado com sucesso!'
                     else
                       'Pedido criado com sucesso, mas não enviado'
                     end
  end

  def order_params
    params.require(:order).permit(:category_id)
  end
end