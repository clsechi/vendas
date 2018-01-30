require 'rails_helper'

feature 'Seller search for customer' do
  scenario 'succesfully' do
    customer = create(:customer, name: 'Maria')

    #login_as seller
    visit root_path
    fill_in 'Busca', with: customer.name
    click_on 'Pesquisar cliente'

    expect(page).to have_link customer.name
    expect(page).to have_content customer.cpf
    expect(page).to have_content customer.phone
  end
  # cliente nao existe
  # busca por cpf
  # busca por cnpj
end
