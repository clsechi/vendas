require 'rails_helper'

feature 'user can access your views' do
  scenario 'successfully' do
    seller = create(:seller)

    visit root_path
    fill_in 'Email', with: seller.email
    fill_in 'Senha', with: seller.password
    click_on 'Entrar'

    expect(page).to have_content("Olá, #{seller.email}")
    expect(page).to have_link('Visualizar meus pedidos')
    expect(page).not_to have_link('Entrar')
  end

  scenario 'user admin access your view' do
    admin = create(:seller, admin: true)

    visit root_path
    fill_in 'Email', with: admin.email
    fill_in 'Senha', with: admin.password
    click_on 'Entrar'

    expect(page).to have_content("Olá, #{admin.email}")
    expect(page).to have_link('Visualizar todos pedidos')
    expect(page).not_to have_link('Entrar')
  end
end
