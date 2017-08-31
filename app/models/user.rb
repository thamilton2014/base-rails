# app/models/user.rb
class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # Model associations
  has_many :todos, foreign_key: :created_by

  has_many :status_events, foreign_key: :created_by

  has_many :push_events, foreign_key: :created_by

  has_many :pull_requests, foreign_key: :created_by

  # Validations
  validates_presence_of :name, :email, :password_digest
end