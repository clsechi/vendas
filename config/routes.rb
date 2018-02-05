Rails.application.routes.draw do
  devise_for :sellers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"

  resources :sellers, only:[:new, :show]
  post 'sellers/create_seller', to: 'sellers#create_seller', as: 'create_seller'


  resources :orders, only:[:index, :show, :new, :create]

  resources :customers, only: [:new, :create, :show] do
    collection do
      get 'search'
    end
  end
end
