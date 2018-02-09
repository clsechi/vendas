class OrdersController < ApplicationController
  before_action :authenticate_seller!, only: [:index, :new, :create, :show]
  before_action :set_order, only: [:list_products, :set_product, :list_plans,
                                   :set_plan, :list_prices, :set_price, :check,
                                   :show]
  before_action :set_customer, only: [:destroy, :list_products, :list_plans,
                                      :list_prices, :check]

  def index
    @orders = if current_seller.admin?
                Order.all
              else
                Order.where(seller_id: current_seller)
              end
  end

  def new
    uri = URI "#{Rails.configuration.sales['products_url']}/categories"
    categories_json = Net::HTTP.get(uri)
    categories_hash = JSON.parse(categories_json)
    @categories = categories_hash['categories']
                  .map { |category| Category.new category }
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
    @order = @customer.orders.find(params[:id])
    @order.destroy

    flash[:notice] = 'Venda cancelada!'
    redirect_to root_path
  end

  def list_products
    uri = URI "#{Rails.configuration.sales['products_url']}/categories/#{@order
                      .category_id}/products"
    products_json = Net::HTTP.get(uri)
    products_hash = JSON.parse(products_json)
    @products = products_hash['products'].map { |product| Product.new product }
  end

  def set_product
    set_session('product_name', params[:product_name])
    if @order.update(product_id: params[:product_id])
      redirect_to customer_order_plans_path(@order.customer, @order)
    else
      render :products
    end
  end

  def list_plans
    uri = URI "#{Rails.configuration.sales['products_url']}/products/#{@order
                      .product_id}/product_plans"
    plans_json = Net::HTTP.get(uri)
    plans_hash = JSON.parse(plans_json)
    @plans = plans_hash['plans'].map { |plan| Plan.new plan }
  end

  def set_plan
    set_session('plan_name', params[:plan_name])
    if @order.update(plan_id: params[:plan_id])
      redirect_to customer_order_prices_path(@order.customer, @order)
    else
      render :plans
    end
  end

  def list_prices
    uri = URI "#{Rails.configuration
                      .sales['products_url']}/product_plans/#{@order
                      .plan_id}/plan_prices"
    prices_json = Net::HTTP.get(uri)
    prices_hash = JSON.parse(prices_json)
    @prices = prices_hash['prices'].map { |price| Price.new price }
  end

  def set_price
    set_session('price_name', params[:price_name])
    if @order.update(value: params[:value],
                     periodicity_id: params[:periodicity_id])
      redirect_to customer_order_check_path(@order.customer, @order)
    else
      render :prices
    end
  end

  def check; end

  def show; end

  private

  def set_session(session_name, session_value)
    session_name = session_name.to_sym
    session[session_name] = session_value
  end

  def send_order
    flash[:notice] = if OrdersSenderService::OrdersService.send_post(@order)
                       'Pedido criado com sucesso!'
                     else
                       'Pedido criado com sucesso, mas não enviado'
                     end
  end

  def send_email(order_id)
    order = Order.find(order_id)
    OrderMailer.order_email(order).deliver_now
  end

  def order_params
    params.require(:order).permit(:category_id)
  end

  def set_order
    @order = Order.find(params[:order_id])
  end

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end
end
