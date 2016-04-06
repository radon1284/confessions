class EventPublisher
  def self.publish(event)
    PersistedEvent.create!(
      event_type: event.class.name.underscore,
      visitor_identifier: event.visitor.identifier,
      payload: event.payload
    )
  end
end
