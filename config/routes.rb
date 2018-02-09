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

      get 'products', to: 'orders#list_products', as: 'products'
      post 'products', to: 'orders#update_product', as: 'product'

      get 'plans', to: 'orders#list_plans', as: 'plans'
      post 'plans', to: 'orders#update_plan', as: 'plan'

      get 'prices', to: 'orders#list_prices', as: 'prices'
      post 'prices', to: 'orders#update_price', as: 'price'

      get 'check', to: 'orders#check', as: 'check'
      post 'confirm', to: 'orders#confirm', as: 'confirm'

    end

  end
end
