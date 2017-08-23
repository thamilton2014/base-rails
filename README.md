# README

This README would normally document whatever steps are necessary to get the
application up and running.

## Endpoints and functionality

References: 
- https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-one
- https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-two
- https://chriskottom.com/blog/2017/04/versioning-a-rails-api/

* POST /signup
* POST /auth/login
* GET /auth/login
* GET /todos
* POST /todos
* GET /todos/:id
* PUT /todos/:id
* DELETE /todos/:id
* GET /todos/:id/items
* PUT /todos/:id/items
* DELETE /todos/:id/items

## Part I
- Project setup
- TODO's api
- TODO items api

### Project setup

Initialize the spec directory where our rspec tests reside.

```bash
$ rails generaate rspec:install
```

Create a factories directory where we will define the model factories.

```bash
$ mkdir spec/factories
```

### Creating models

```bash
$ rails g model Todo title:string created_by:string
$ rails g model Item name:string done:boolean todo:references
$ rails g model User name:string email:string password_digest:string
```

Run the migrations
```bash
$ rails db:migrate
$ rails db:migrate RAILS_ENV=test
```

### Creating migrations

Adding column

```bash
$ rails generate migration AddCreatedByToStatusEvents

# Edit the file: db/migrate/<timestamp>_add_created_by_to_status_events.rb
class AddCreatedByToStatusEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :status_events, :created_by, :string
  end
end
```

### Creating controllers

```bash
# rails g controller Users
$ rails g controller Todos
$ rails g controller Items
```

Create RSpec request tests
```bash
$ mkdir spec/requests && touch spec/requests/{todos_spec.rb,items_spec.rb,users_spec.rb}
```

Create a model factory to provide the test data
```bash
$ mkdir spec/factories && touch spec/factories/{todos.rb,items.rb,users.rb}
```

Create request spec helper
```bash
$ mkdir spec/support && touch spec/support/{request_spec_helper.rb,controller_spec_helper.rb}
```

Create the authentication controller
```bash
$ rails g controller Authentication
```

Add authentication route to 'config/routes.rb'
```ruby
post 'auth/login', to: 'authentication#authenticate'
```

### Rails routes

To view the rails routes use:

```bash
$ rails routes
```

## Running Unit Tests

```bash

```
### Setting up Token Based Authentication

Reference: https://github.com/rails/rails/issues/13142

```bash
$ mkdir app/lib & touch app/lib/json_web_token.rb
```

Now define the JWT singleton.
```ruby
# app/lib/json_web_token.rb
class JsonWebToken
  # secret to encode and decode token
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  def self.encode(payload, exp = 24.hours.from_now)
    # set expiry to 24 hours from creation time
    payload[:exp] = exp.to_i
    # sign token with application secret
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    # get payload; first index in decoded Array
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new body
      # rescue from expiry exception
  rescue JWT::ExpiredSignature, JWT::VerificationError => e
    # raise custom error to be handled by custom handler
    raise ExceptionHandler::ExpiredSignature, e.message
  end
end
```

Now create a class that is responsible for authorizing all API requests and making sure the requests have a valid token 
and user payload

```bash
# Create the auth folder to house auth services
$ mkdir app/auth & touch app/auth/authorize_api_request.rb

# Create the corresponding spec files
$ mkdir spec/auth & touch spec/auth/authorized_api_request_spec.rb
```

### Curl Example

Create a user
```bash
$ curl -H "Content-Type: application/json" localhost:3000/signup -d '{"name": "example_user", "email": "example_user@gmail.com", "password": "example_password", "password_confirmation": "example_password"}'
```

Create a status event
```bash

$ curl -H "Content-Type: application/json" -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE1MDM1ODgxMzJ9.aoMumHU7nqpzdbDX6999qh0FHkJPRCcbgTuTaixp1wA" localhost:3000/status_events -d '{"sha": "9049f1265b7d61be4a8904a9a27120d2064dab3b", "state": "pending", "description": "Test", "target_url": "https://www.google.com"}'
```

Get all todos in the list
```bash
$ curl -H "Authorization: <example_token_here>" localhost:3000/todos
```

## Todo

### Models
Create some more baseline models
```bash
$ rails g model Job title:string created_by:string name:string
$ rails g model Profile first_name:string last_name:string
$ rails g model Contact first_name:string last_name:string email:string
```

### Controllers
Create some more baseline controllers
```bash
$ rails g controller Profiles
$ rails g controller Contacts
$ rails g controller Jobs
```

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

```bash
$ bundle exec rspec
```

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
