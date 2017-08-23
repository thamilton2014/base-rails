# spec/factories/status_events.rb
FactoryGirl.define do
  factory :status_event do
    sha { Faker::Crypto.sha1 }
    state { "pending" }
    description { Faker::Lorem.sentence(3) }
    target_url { Faker::Internet.url }
  end
end