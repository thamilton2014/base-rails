# spec/models/status_event_spec.rb
require 'rails_helper'

RSpec.describe StatusEvent, type: :model do
  it { should validate_presence_of(:sha) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:target_url) }
end
