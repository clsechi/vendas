Rails.application.routes.draw do
  devise_for :sellers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :orders, only:[:index, :show]
  root to: "home#index"
  resources :customers, only: [:new, :create, :show] do
    collection do
      get 'search'
    end
  end



end
