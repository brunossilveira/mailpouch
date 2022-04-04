Rails.application.routes.draw do
  resources :inbox, only: [:index]
end
