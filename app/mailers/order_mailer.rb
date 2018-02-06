class OrderMailer < ApplicationMailer
  default from: 'no-reply@locaweb.com.br'

  def order_email(order)
    @customer = order.customer
    @order = order
    mail(to: @customer.email, subject: 'Pedido realizado com sucesso')
  end
end
