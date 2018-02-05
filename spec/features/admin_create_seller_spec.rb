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
    click_on 'Criar'

    expect(page).to have_content('Vendedor Um')
    expect(page).to have_content('vendedor@teste.com')
    expect(page).to have_content('Vendedor criado com sucesso')
  end
end
