Rails.application.routes.draw do
  devise_for :sellers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"

  resources :orders, only:[:index, :show]

  resources :customers, only:[:new, :create, :show] do
    collection do
      get 'search'
    end
    resources :orders, only:[:show, :new, :create] do

      get 'products', to: 'orders#list_products', as: 'products'
      post 'products', to: 'orders#set_product', as: 'product'

      get 'plans', to: 'orders#list_plans', as: 'plans'
      post 'plans', to: 'orders#set_plan', as: 'plan'

      get 'prices', to: 'orders#list_prices', as: 'prices'
      post 'prices', to: 'orders#set_price', as: 'price'

      get 'check', to: 'orders#check', as: 'check'
      post 'confirm', to: 'orders#confirm', as: 'confirm'

    end
  end
end
