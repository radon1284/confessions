FactoryGirl.define do
  factory :persisted_event do
    event_type "my_custom_event"
    visitor_identifier "unique"
  end
end
