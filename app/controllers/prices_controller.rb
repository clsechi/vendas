class PricesController < ApplicationController
  before_action :find_order, only: [:index, :update]
  before_action :find_customer, only: [:index, :update]

  def index
    @prices = Price.all @order
  end

  def update
    set_session('price_name', params[:price_name])
    if @order.update(value: params[:value],
                     periodicity_id: params[:periodicity_id])
      redirect_to customer_order_check_path(@order.customer, @order)
    else
      render :prices
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
