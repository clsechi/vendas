class SellersController < ApplicationController
  def new
    @seller = Seller.new
  end

  def create_seller
    @seller = Seller.new(seller_params)
    if @seller.save
      flash[:notice] = 'Vendedor criado com sucesso'
      redirect_to @seller
    else
      flash.now[:fail] = 'Falha ao cadastrar o Vendedor'
      render :new
    end
  end

  def show
    @seller = Seller.find(params[:id])
  end

  private

  def seller_params
    params.require(:seller).permit(:email, :password, :name)
  end
end
