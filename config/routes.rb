Rails.application.routes.draw do
  devise_for :sellers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"

  resources :orders, only:[:index, :show]
  resources :sellers, only:[:new, :show]

  post 'sellers/create_seller', to: 'sellers#create_seller', as: 'create_seller'

  resources :customers, only: [:index, :new, :create, :show, :edit, :update] do
    collection do
      get 'search'
    end
    resources :orders, only:[:show, :new, :create, :destroy] do
      resources :products, only:[:index, :update]
      resources :plans, only:[:index, :update]
      resources :prices, only:[:index, :update]

      get 'check', to: 'orders#check', as: 'check'
      post 'confirm', to: 'orders#confirm', as: 'confirm'

    end
  end
end
