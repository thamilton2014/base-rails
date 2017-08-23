# spec/models/push_event_spec.rb
require 'rails_helper'

RSpec.describe PushEvent, type: :model do
  it { should validate_presence_of(:ref) }
  it { should validate_presence_of(:head) }
  it { should validate_presence_of(:before) }
  it { should validate_presence_of(:size) }
  it { should validate_presence_of(:distinct_size) }
end
