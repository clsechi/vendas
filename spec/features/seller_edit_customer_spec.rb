require 'rails_helper'

feature 'seller edit customer' do
  scenario 'succesfully' do
    seller = create(:seller)
    customer = create(:customer, :legal)

    login_as(seller)
    visit root_path

    fill_in 'Busca', with: customer.name
    click_on 'Pesquisar cliente'

    click_on customer.name
    click_on 'Editar'

    fill_in 'Nome', with: 'Maria'
    fill_in 'Endereco', with: 'rua das flores'
    fill_in 'CPF', with: '777777777-77'
    fill_in 'Email', with: 'email@email.com'
    fill_in 'Telefone', with: '1199999999'
    fill_in 'Data de Nascimento', with: '1988-02-29'

    click_on 'Enviar'

    expect(page).to have_content('Maria')
    expect(page).to have_content('rua das flores')
    expect(page).to have_content('777777777-77')
    expect(page).to have_content('email@email.com')
    expect(page).to have_content('29/02/1988')
  end
  scenario 'and must fill all fields', :js do
    seller = create(:seller)
    customer = create(:customer, :legal)

    login_as(seller)
    visit root_path

    fill_in 'Busca', with: customer.name
    click_on 'Pesquisar cliente'

    click_on customer.name
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Endereco', with: ''
    fill_in 'Email', with: ''
    check 'legal_checkbox'
    fill_in 'Nome da Companhia', with: ''
    fill_in 'Contato', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Voce deve preencher todos os campos')
  end
end
