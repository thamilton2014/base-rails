# spec/models/push_event_spec.rb
require 'rails_helper'

RSpec.describe PushEvent, type: :model do
  it {should validate_presence_of(:ref)}
  it {should validate_presence_of(:after)}
end # => end PushEvent
