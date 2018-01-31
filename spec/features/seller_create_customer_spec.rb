require 'rails_helper'

feature 'seller create customer' do
  scenario 'succesfully' do
    seller = create(:seller)

    login_as(seller)
    visit root_path

    click_on 'Novo Cliente'

    fill_in 'Nome', with: 'Maria'
    fill_in 'Endereco', with: 'rua das flores'
    fill_in 'CPF', with: '777777777-77'
    fill_in 'Email', with: 'email@email.com'
    fill_in 'Telefone', with: '1199999999'
    fill_in 'Data de Nascimento', with: '29/02/1988'

    click_on 'Enviar'

    expect(page).to have_content('Maria')
    expect(page).to have_content('rua das flores')
    expect(page).to have_content('777777777-77')
    expect(page).to have_content('email@email.com')
    expect(page).to have_content('1988-02-29')
  end
  scenario 'and create a PJ customer' do
    seller = create(:seller)

    login_as(seller)
    visit root_path
    click_on 'Novo Cliente'

    fill_in 'Nome', with: 'Maria'
    fill_in 'Endereco', with: 'rua das flores'
    fill_in 'CNPJ', with: '93.167.578/0001-18'
    fill_in 'Email', with: 'email@email.com'
    fill_in 'Nome da Companhia', with: 'floricultura da Maria'
    fill_in 'Contato', with: '1199999999'
    click_on 'Enviar'

    expect(page).to have_content('Maria')
    expect(page).to have_content('rua das flores')
    expect(page).to have_content('93.167.578/0001-18')
    expect(page).to have_content('email@email.com')
    expect(page).to have_content('floricultura da Maria')
    expect(page).to have_content('1199999999')
  end
end
