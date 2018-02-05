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
    @order = Order.new
    # json = '[{"name": "Hospedagem", "id": 1, "periodicity": [{"period: "1
    # mes", value: "100,00"}]}]'

    @categories = parse_categories
  end

  def create
    @order = Order.new order_params

    @order.customer_id = current_seller.id
    @order.seller_id = current_seller.id

    if @order.save
      flash[:notice] = 'Pedido criado com sucesso!'
      redirect_to @order
      # send data to painel
    else
      @categories = parse_categories
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:category_id)
  end

  def parse_categories
    categories_json = '[{"id": 1,"name": "Hospedagem"}, '\
                      '{"id": 2,"name": "Cloud e Servidores"},{"id": '\
                      '3,"name": "Loja Virtual"} ]'
    categories_hash = JSON.parse(categories_json)
    categories_hash.map do |category|
      Category.new(category)
    end
  end
end
