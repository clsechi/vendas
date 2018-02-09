require 'rails_helper'

feature 'seller create customer' do
  scenario 'succesfully' do
    seller = create(:seller)

    login_as(seller)
    visit root_path

    fill_in 'Busca', with: '777777777-77'
    click_on 'Pesquisar cliente'
    click_on 'Novo Cliente'

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
  scenario 'and create a PJ customer' do
    seller = create(:seller)

    login_as(seller)
    visit root_path
    fill_in 'Busca', with: '777777777-77'
    click_on 'Pesquisar cliente'
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
  scenario 'and must fill all fields' do
    seller = create(:seller)

    login_as(seller)
    visit root_path
    fill_in 'Busca', with: '777777777-77'
    click_on 'Pesquisar cliente'
    click_on 'Novo Cliente'

    fill_in 'Nome', with: ''
    fill_in 'Endereco', with: ''
    fill_in 'Email', with: ''
    fill_in 'Nome da Companhia', with: ''
    fill_in 'Contato', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Voce deve preencher todos os campos')
  end
  scenario 'and email is unique' do
    seller = create(:seller)
    create(:customer, :legal, email: 'email@repetido.com')

    login_as(seller)
    visit root_path
    fill_in 'Busca', with: '93.167.578/0001-18'
    click_on 'Pesquisar cliente'
    click_on 'Novo Cliente'

    fill_in 'Nome', with: 'Maria'
    fill_in 'Endereco', with: 'rua das flores'
    fill_in 'CNPJ', with: '93.167.578/0001-18'
    fill_in 'Email', with: 'email@repetido.com'
    fill_in 'Nome da Companhia', with: 'floricultura da Maria'
    fill_in 'Contato', with: '1199999999'
    click_on 'Enviar'

    expect(page).to have_content('Email já está em uso')
  end
  scenario 'and cpf is unique' do
    seller = create(:seller)
    customer = create(:customer, :legal, cpf: '268.321.401-42')

    login_as(seller)
    visit root_path
    fill_in 'Busca', with: customer.name
    click_on 'Pesquisar cliente'
    click_on 'Novo Cliente'

    fill_in 'Nome', with: 'Maria'
    fill_in 'Endereco', with: 'rua das flores'
    fill_in 'CPF', with: '268.321.401-42'
    fill_in 'Email', with: 'email@email.com'
    fill_in 'Telefone', with: '1199999999'
    fill_in 'Data de Nascimento', with: '1988-02-29'
    click_on 'Enviar'

    expect(page).to have_content('CPF já está em uso')
  end
  scenario 'and cnpj is unique' do
    seller = create(:seller)
    customer = create(:customer, :company, cnpj: '89.495.945/0001-35')

    login_as(seller)
    visit root_path
    fill_in 'Busca', with: customer.name
    click_on 'Pesquisar cliente'
    click_on 'Novo Cliente'

    fill_in 'Nome', with: 'Maria'
    fill_in 'Endereco', with: 'rua das flores'
    fill_in 'CNPJ', with: '89.495.945/0001-35'
    fill_in 'Email', with: 'email@email.com'
    fill_in 'Nome da Companhia', with: 'floricultura da Maria'
    fill_in 'Contato', with: '1199999999'
    click_on 'Enviar'

    expect(page).to have_content('CNPJ já está em uso')
  end
  scenario 'and permit create two customer as same type (PJ)' do
    seller = create(:seller)

    login_as(seller)
    visit root_path
    click_on 'Pesquisar cliente'
    click_on 'Novo Cliente'

    fill_in 'Nome', with: 'Maria'
    fill_in 'Endereco', with: 'rua das flores'
    fill_in 'CNPJ', with: '89.495.945/0001-35'
    fill_in 'Email', with: 'email@email.com'
    fill_in 'Nome da Companhia', with: 'floricultura da Maria'
    fill_in 'Contato', with: '1199999999'
    click_on 'Enviar'
    click_on 'Voltar'
    click_on 'Pesquisar cliente'
    click_on 'Novo Cliente'
    fill_in 'Nome', with: 'João'
    fill_in 'Endereco', with: 'rua 13 de maio'
    fill_in 'CNPJ', with: '63.755.929/0001-25'
    fill_in 'Email', with: 'email_user@email.com'
    fill_in 'Nome da Companhia', with: 'floricultura da Maria'
    fill_in 'Contato', with: '11999889'
    click_on 'Enviar'
    click_on 'Clientes'

    expect(page).to have_link('Maria')
    expect(page).to have_link('João')
    expect(current_path).to eq customers_path
  end
end
