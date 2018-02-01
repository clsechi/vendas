Rails.application.routes.draw do
  devise_for :sellers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"

  get '/new_seller', to: 'home#new_seller'
  post '/create_seller', to: 'home#create_seller'
  get '/seller/:id', to: 'home#show_seller'

  resources :orders, only:[:index, :show, :new, :create]

  resources :customers, only: [:new, :create, :show] do
    collection do
      get 'search'
    end
  end

end
