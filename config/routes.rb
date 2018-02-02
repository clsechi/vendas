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
      #get '/new', to: 'orders#categories'
      #post ':category_id', to: 'orders#category', as: 'category'

      get '/:category_id', to: 'orders#products', as: 'products'
      post '/:category_id', to: 'orders#product', as: 'product'

      get '/:category_id/:product_id', to: 'orders#plans', as: 'plans'
      post '/:category_id/:product_id', to: 'orders#plan', as: 'plan'

      get '/:category_id/:product_id/:plan_id/', to: 'orders#confirm', as: 'confirm'
      post '/:category_id/:product_id/:plan_id/:per_id/:status', to: 'orders#create', as: 'set_status'

    end
  end
end
