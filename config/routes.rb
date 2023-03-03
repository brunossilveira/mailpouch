Rails.application.routes.draw do
  require 'sidekiq/web'

  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'

    namespace :admin do
      resources :newsletter_messages
      resources :newsletters
      resources :users

      root to: "users#index"
    end
  end

  root to: 'home#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :inbox, only: [:index]
  resources :newsletters
  resources :newsletter_messages, only: [:show]

  namespace :inbox do
    resources :read, only: [:index, :create]
  end

  get "/profile" => "profile#edit", as: "profile"
  patch "/profile" => "profile#update", as: "edit_profile"
  post "users/preferences" => "users/preferences#create", as: :save_preferences
  get "/newsletter_messages/:id/read" => "newsletter_messages#read", as: :mark_as_read
  get "/newsletter_messages/:id/parsed" => "newsletter_messages#parsed"
  get "checkout", to: "checkout#show"
  get "pricing", to: "pricing#show"
  get "/:page" => "pages#show"
end
