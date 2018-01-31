require 'rails_helper'

feature 'Seller search for customer' do
  scenario 'succesfully' do
    customer = create(:customer, name: 'Maria')
    seller = create(:seller)

    login_as seller
    visit root_path
    fill_in 'Busca', with: customer.name
    click_on 'Pesquisar cliente'

    expect(page).to have_link customer.name
    expect(page).to have_content customer.cpf
    expect(page).to have_content customer.phone
  end
  scenario 'and customer doesnt exist' do
    seller = create(:seller)

    login_as seller
    visit root_path

    fill_in 'Busca', with: 'Maria'
    click_on 'Pesquisar cliente'

    expect(page).not_to have_link 'Maria'
    expect(page).to have_content 'Cliente nao encontrado'
  end
  scenario 'and search by CPF' do
    customer = create(:customer, cpf: '178.846.166-53')
    seller = create(:seller)

    login_as seller
    visit root_path
    fill_in 'Busca', with: customer.cpf
    click_on 'Pesquisar cliente'

    expect(page).to have_link customer.name
    expect(page).to have_content customer.cpf
    expect(page).to have_content customer.phone
  end
  scenario 'and search by CNPJ' do
    customer = create(:customer, cnpj: '25.319.386/0001-20')
    seller = create(:seller)

    login_as seller
    visit root_path
    fill_in 'Busca', with: customer.cnpj
    click_on 'Pesquisar cliente'

    expect(page).to have_link customer.name
    expect(page).to have_content customer.cnpj
    expect(page).to have_content customer.phone
  end
end
