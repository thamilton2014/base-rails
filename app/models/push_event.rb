# app/models/push_event.rb
class PushEvent < ApplicationRecord
  # Model validations
  validates_presence_of :ref, :after
end # => end PushEvent
