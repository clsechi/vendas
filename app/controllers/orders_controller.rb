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
    @categories = parse_categories
  end

  def create
    @order = Order.new order_params

    @order.customer_id = current_seller.id
    @order.seller_id = current_seller.id

    if @order.save
      if OrdersSenderService::OrdersService.send_post(@order)
        flash[:notice] = 'Pedido criado com sucesso!'
      else
        flash[:notice] = 'Pedido criado com sucesso, mas não enviado'
      end
      redirect_to @order
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
