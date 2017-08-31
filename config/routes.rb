# config/routes.rb
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #
  # To view the routes run:
  #   $ rails routes
  #

  # The sign-up route
  post 'signup', to: 'users#create'

  # Authentication endpoint
  post 'auth/login', to: 'authentication#authenticate'

  # Create a base resource
  resources :todos do
    # Nest the item resource, this enforces the 1:m (one to many) association at the routing level.
    resources :items
  end

  # Status Events
  resources :status_events do
    # Nest any resources here. This enforces the 1:m association at the routing level.
  end

  # Pull Request Events
  resources :pull_requests do

  end

  # Push Events
  resources :push_events do

  end

  # Adding SideKiq routes
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
