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
end
