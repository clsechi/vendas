class OrderMailer < ApplicationMailer
  default from: 'no-reply@locaweb.com.br'

  def order_email(customer, message, order)
   @customer = customer
   @msg = message
   @order = order
   mail(to: @customer.email, subject: 'Pedido realizado com sucesso')
  end
end
