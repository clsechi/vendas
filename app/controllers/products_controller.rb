class ProductsController < ApplicationController
  before_action :find_order, only: [:index, :update]
  before_action :find_customer, only: [:index, :update]

  def index
    @products = Product.all @order
  end

  def update
    set_session('product_name', params[:product_name])
    if @order.update(product_id: params[:product_id])
      redirect_to customer_order_plans_path(@order.customer, @order)
    else
      render :products
    end
  end

  private

  def find_order
    @order = Order.find(params[:order_id])
  end

  def find_customer
    @customer = Customer.find(params[:customer_id])
  end
end
