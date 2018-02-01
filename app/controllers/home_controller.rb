class HomeController < ApplicationController
  before_action :authenticate_seller!, only: [:index, :show]
  def index() end

  def show() end

  def new_seller
    @seller = Seller.new
  end

  def create_seller
    @seller = Seller.new(seller_params)
    @seller.save
    redirect_to create_seller(@seller)
  end

  private
  def seller_params
     params.require(:seller).permit(:email, :password, :name)
  end
end
