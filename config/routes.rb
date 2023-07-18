Rails.application.routes.draw do
  require 'sidekiq/web'

  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'

    namespace :admin do
      resources :posts
      resources :newsletter_messages
      resources :newsletters
      resources :newsletter_subscriptions
      resources :users
      resources :events

      root to: "users#index"
    end
  end

  root to: 'home#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :inbox, only: [:index]
  resources :newsletter_subscriptions
  resources :newsletter_messages, only: [:show]

  namespace :inbox do
    resources :read, only: [:index, :create]
  end

  get "/profile" => "profile#edit", as: "profile"
  patch "/profile" => "profile#update", as: "edit_profile"
  post "users/preferences" => "users/preferences#create", as: :save_preferences
  get "/newsletter_messages/:id/read" => "newsletter_messages#read", as: :mark_as_read
  get "/best-:category-newsletters" => "best_newsletters#index"
  get "/best-newsletters" => "newsletter_database#index"
  get "/newsletter_messages/:id/parsed" => "newsletter_messages#parsed"
  get "/:id/parsed" => "newsletter_messages#parsed"
  get "checkout", to: "checkout#show"
  get "pricing", to: "pricing#show"
  get "/send_reminder" => "send_reminder#index"
  get '/sitemap.xml', to: 'sitemap#index', as: 'sitemap'

  resources :posts, only: [:index, :show]

  # This needs to always be last
  get "/:page" => "pages#show"
end
