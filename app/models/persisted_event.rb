class PersistedEvent < ActiveRecord::Base
  validates :visitor_identifier, :event_type, presence: true
end
