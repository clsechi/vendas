class CustomersController < ApplicationController
  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer
    else
      flash.now[:notice] = 'Voce deve preencher todos os campos'
      render 'new'
    end

  end

  def show
    @customer = Customer.find(params[:id])
  end

  def search
    @search_param = params[:search]
    @customers = Customer.where('name like ? OR cpf = ? OR cnpj = ?',
                                "%#{@search_param}%", @search_param,
                                @search_param)
    flash[:notice] = 'Cliente nao encontrado' if @customers.empty?
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :address, :cpf, :email, :phone,
                                     :birth_date, :cnpj, :company_name,
                                     :contact)
  end
end
