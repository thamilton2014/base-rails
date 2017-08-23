# app/models/user.rb
class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # Model associations
  has_many :todos, foreign_key: :created_by

  # TODO - create foreign key
  has_many :status_events, foreign_key: :created_by

  # Validations
  validates_presence_of :name, :email, :password_digest
end