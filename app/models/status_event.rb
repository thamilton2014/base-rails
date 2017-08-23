# app/models/status_event.rb
class StatusEvent < ApplicationRecord
  # model association
  # N/A

  # validations
  validates_presence_of :sha, :state, :description, :target_url
end
