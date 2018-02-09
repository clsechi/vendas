class PlansController < ApplicationController
  before_action :find_order, only: [:index, :update]
  before_action :find_customer, only: [:index, :update]

  def index
    @plans = Plan.all @order
  end

  def update
    set_session('plan_name', params[:plan_name])
    if @order.update(plan_id: params[:plan_id])
      redirect_to customer_order_prices_path(@order.customer, @order)
    else
      render :plans
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
