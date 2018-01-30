require 'rails_helper'

feature 'user views orders list' do
  scenario 'successfully' do
    customer = create(:customer)
    order = create(:order, customer: customer)

    visit root_path

    click_on 'Visualizar todos pedidos'

    expect(page).to have_link(order.id)
  end
end
