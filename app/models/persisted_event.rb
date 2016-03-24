class PersistedEvent < ActiveRecord::Base
  validates_presence_of :visitor_identifier, :event_type
end
