class OrdersController < ApplicationController
  before_action :authenticate_seller!, only: [:index, :new, :create, :show]
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
    #@order = Order.new
    @categories = get_categories
  end

  def create
    if @order.save
      pp @order
      redirect_to customer_order_products_path(@order.category_id)
      #send data to painel
    else
      @categories = get_categories
      render :new
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
  end

  def set_order
    @order = Order.new order_params
    @order.customer_id = params[:customer_id]
    @order.seller_id = current_seller.id
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

end
