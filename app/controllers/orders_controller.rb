class OrdersController < ApplicationController

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
    pl_id = params[:plan_id]
    pl_price = params[:price]
    if @order.update(plan_id: pl_id, price: pl_price)
      redirect_to customer_order_confirm_path(@order.customer_id, @order.category_id,
         @order.id, @order.product_id, @order.plan_id)
    else
      @plans = get_plans
      render :plans
    end
  end

  def confirm
    @order = Order.find(params[:order_id])
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def set_session(session_name, session_value)
    session_name = session_name.to_hash
    session[session_name] = session_value
  end

  def get_categories
    categories_json = '[{"id": 1,"name": "Hospedagem"}, {"id": 2,"name": "Cloud e Servidores"},{"id": 3,"name": "Loja Virtual"} ]'
    categories_hash = JSON.parse(categories_json)

    categories = []

    categories_hash.each do |category|
      categories << Category.new(category)
    end
    categories
  end

  def get_products
    products_json = '[{"id": 1, "name": "Hospedagem de sites"}, {"id": 2, "name": "Registro de dominios"},
     {"id": 3, "name": "SSL de Locaweb"}]'
    products_hash = JSON.parse(products_json)

    products = []

    products_hash.each do |product|
      products << Product.new(product)
    end
    products
  end

  def get_plans
    plans_json = '[{"id": 1, "name": "Hospedagem I", "price": "60,00"}, {"id": 2, "name": "Hospedagem II", "price": "100,00"},
                    {"id": 3, "name": "Hospedagem III", "price": "150,00"}]'
    plans_hash = JSON.parse(plans_json)
    plans = []

    plans_hash.each do |plan|
      plans << Plan.new(plan)
    end
    plans
  end
end
