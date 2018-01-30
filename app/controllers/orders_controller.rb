class OrdersController < ApplicationController

  def new
    @order = Order.new
    json = '[{"name": "Hospedagem", "id": 1, "periodicity": [{"period: "1 mês", value: "100,00"}]}]'
    json_object = JSON.parse(json, object_class: OpenStruct)
    @products = json_object



    pp @products
  end

end
