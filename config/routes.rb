Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users

  resources :inbox, only: [:index]
  resources :newsletters
end
