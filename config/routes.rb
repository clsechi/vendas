Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :orders, only:[:index, :show]
  root to: "home#index"
end
