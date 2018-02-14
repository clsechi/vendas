class OrdersController < ApplicationController
  before_action :authenticate_seller!, only: [:index, :new, :create, :show]
  before_action :find_order, only: [:check, :confirm]
  before_action :find_customer, only: [:destroy, :check]

  def index
    @orders = list_orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @categories = Category.all
  end

  def create
    set_session('category_name', params[:category_name])
    @order = Order.new(customer_id: params[:customer_id],
                       category_id: params[:category_id],
                       seller_id: current_seller.id,
                       already_posted: false, ready: false)
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

  def check
    @order&.update(ready: true)
  end

  def confirm
    send_order @order.id if @order.ready?
    send_email @order.id if @order.ready?
  end

  def pending
    @orders = Order.where(already_posted: false)
  end

  def resend
    @order = Order.find(params[:id])
    send_order @order.id
    send_email @order.id
    redirect_to root_path
  end

  private

  def send_order(order_id)
    order = Order.find(order_id)
    if OrdersSenderService::OrdersService.send_post(order)
      order.update(already_posted: true)
      flash[:created] = 'Pedido criado com sucesso!'
    else
      order.update(already_posted: false)
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
