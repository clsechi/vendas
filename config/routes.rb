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

      get '/:category_id', to: 'orders#products', as: 'products'
      post '/:category_id', to: 'orders#product', as: 'product'

      get '/:category_id/:product_id', to: 'orders#plans', as: 'plans'
      post '/:category_id/:product_id', to: 'orders#plan', as: 'plan'

      get '/:category_id/:product_id/:plan_id', to: 'orders#prices', as: 'prices'
      post '/:category_id/:product_id/:plan_id', to: 'orders#set_price', as: 'set_price'

      get '/:category_id/:product_id/:plan_id/check', to: 'orders#check', as: 'check'
      post '/confirm', to: 'orders#confirm', as: 'confirm'

    end
  end
end
