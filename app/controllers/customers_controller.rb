class CustomersController < ApplicationController
  before_action :authenticate_seller!, only: [:new, :create, :show, :search]

  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer
    else
      flash.now[:fail] = 'Voce deve preencher todos os campos'
      render :new
    end
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:success] = 'Cliente atualizado com sucesso'
      redirect_to @customer
    else
      flash.now[:fail] = 'Voce deve preencher todos os campos'
      render :edit
    end
  end

  def search
    @search_param = params[:search]
    @customers = Customer.where('name like ? OR cpf = ? OR cnpj = ?',
                                "%#{@search_param}%", @search_param,
                                @search_param)
    flash[:not_found] = 'Cliente nao encontrado' if @customers.empty?
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :address, :cpf, :email, :phone,
                                     :birth_date, :cnpj, :company_name,
                                     :contact)
  end
end
