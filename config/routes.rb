Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users

  resources :inbox, only: [:index]
  resources :newsletters

  get "/profile" => "profile#edit", as: "profile"
  patch "/profile" => "profile#update", as: "edit_profile"
  post "users/preferences" => "users/preferences#create", as: "save_preferences"
  get "/newsletter_messages/:id/body" => "newsletter_messages#body"
end
