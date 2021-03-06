require 'rails_helper'

feature 'Admin create seller' do
  scenario 'successfully' do
    admin = create(:seller, admin: true)

    login_as(admin)
    visit root_path
    click_on 'Criar novo vendedor'
    fill_in 'Email', with: 'vendedor@teste.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Nome', with: 'Vendedor Um'
    click_on 'Enviar'

    expect(page).to have_content('Vendedor Um')
    expect(page).to have_content('vendedor@teste.com')
    expect(page).to have_content('Vendedor criado com sucesso')
  end

  scenario "Seller can't create other seller" do
    seller = create(:seller, admin: false)

    login_as(seller)
    visit root_path

    expect(page).not_to have_link('Criar')
  end

  scenario "Admin can't create the same seller twice" do
    admin = create(:seller, admin: true)
    create(:seller, email: 'vendedor@teste.com')
    login_as(admin)
    visit root_path
    click_on 'Criar novo vendedor'
    fill_in 'Email', with: 'vendedor@teste.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Nome', with: 'Vendedor Um'
    click_on 'Enviar'

    expect(page).to have_content('Falha ao cadastrar o Vendedor')
  end

  scenario 'Sellers name cant be blank' do
    admin = create(:seller, admin: true)

    login_as(admin)
    visit root_path
    click_on 'Criar novo vendedor'
    fill_in 'Email', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Falha ao cadastrar o Vendedor')
  end
end
