class OrdersController < ApplicationController
  def index
    if current_seller.admin?
      @orders = Order.all
    else
      @orders = Order.where(seller_id: current_seller)
    end
  end
end
