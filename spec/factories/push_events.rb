# spec/factories/push_events.rb
FactoryGirl.define do
  factory :push_event do
    ref {Faker::Crypto.sha1}
    add_attribute(:after) {Faker::Crypto.sha1}
  end
end # => end FactoryGirl