class OrdersController < ApplicationController
  before_action :authenticate_seller!, only: [:index, :new, :create, :show]
  before_action :find_order, only: [:check]
  before_action :find_customer, only: [:destroy, :check]

  def index
    @orders = list_orders
  end

  def new
    @categories = Category.all
  end

  def create
    set_session('category_name', params[:category_name])
    @order = Order.new(customer_id: params[:customer_id],
                       category_id: params[:category_id],
                       seller_id: current_seller.id)
    if @order.save
      redirect_to customer_order_products_path(@order.customer, @order)
    else
      render :new
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    flash[:notice] = 'Venda cancelada!'
    redirect_to root_path
  end

  def check; end

  def show
    @order = Order.find(params[:id])
  end

  private

  def send_order
    if OrdersSenderService::OrdersService.send_post(@order)
      flash[:notice] = 'Pedido criado com sucesso!'
    else
      flash[:alert] = 'Pedido criado com sucesso, mas não enviado'
    end
  end

  def send_email(order_id)
    order = Order.find(order_id)
    OrderMailer.order_email(order).deliver_now
  end

  def order_params
    params.require(:order).permit(:category_id)
  end

  def find_order
    @order = Order.find(params[:order_id])
  end

  def find_customer
    @customer = Customer.find(params[:customer_id])
  end

  def list_orders
    return Order.all if current_seller.admin?
    Order.where(seller_id: current_seller)
  end
end
