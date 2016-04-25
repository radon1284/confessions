class EventPublisher
  @handlers = Hash.new { |hash, key| hash[key] = [] }

  def self.publish(event)
    @handlers[event.class.name].each do |handler|
      handler.call(event)
    end
  end

  def self.push_handler(event_class, handler)
    @handlers[event_class.name] << handler
  end

  def self.clear_handlers(event_class)
    @handlers[event_class.name] = []
  end
end
