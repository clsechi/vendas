class CustomersController < ApplicationController
  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    redirect_to @customer if @customer.save
  end

  def show
    @customer = Customer.find(params[:id])
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :address, :cpf, :email, :phone,
                                     :birth_date, :cnpj, :company_name,
                                     :contact)
  end
end
