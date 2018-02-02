Rails.application.routes.draw do
  devise_for :sellers, controllers: { registrations: 'sellers/registrations'}

  devise_scope :seller do
    get 'new_seller', to: 'sellers/registrations#new_seller'
    post 'create_sellers', to: 'sellers/registrations#create_seller'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"

  resources :orders, only:[:index, :show, :new, :create]

  resources :customers, only: [:new, :create, :show] do
    collection do
      get 'search'
    end
  end
end
