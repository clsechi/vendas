class OrdersController < ApplicationController
  # <%= link_to "Add Product", new_product_path(:param1 => "value1", :param2 => "value2") %>

  def index
    if current_seller.admin?
      @orders = Order.all
    else
      @orders = Order.where(seller_id: current_seller)
    end
  end

  #def new
    #json = '[{"name": "Hospedagem", "id": 1, "periodicity": [{"period: "1 mês", value: "100,00"}]}]'
    #@order.customer_id = params[:customer_id]
  #end

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
    if @order.update order_params
      redirect_to customer_order_plans_path(@order.category_id, @order.product_id)
    else
      @products = get_products
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def set_session(session_name, session_value)
    session_name = session_name.to_hash
    session[session_name] = session_value
  end

  def order_params
    params.permit(:category_id)
    params.permit(:product_id)
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
end
