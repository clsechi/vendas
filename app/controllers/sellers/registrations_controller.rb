class Sellers::RegistrationsController < Devise::RegistrationsController
  def new_seller
    @seller = Seller.new
  end

  def create_seller
    @seller = Seller.new(seller_params)
    if @seller.save
      flash[:notice] = 'Vendedor criado com sucesso'
    else
      flash[:alert] = 'Usuário já cadastrado'
    end
    redirect_to root_path
  end

  private

  def seller_params
    params.require(:seller).permit(:email, :password, :name)
  end
end
