require "rails_helper"

describe PersistEvent do
  class MockEvent
    def visitor
      Visitor.new("abc")
    end

    def payload
      { test: "payload" }
    end
  end

  let!(:service) { PersistEvent.build }

  it "creates a new persisted event" do
    expect { service.call(MockEvent.new) }
      .to change { PersistedEvent.count }.by(1)
  end

  it "uses the class name as event type" do
    service.call(MockEvent.new)
    expect(PersistedEvent.last.event_type).to eq "mock_event"
  end

  it "stores the visitor identifier" do
    service.call(MockEvent.new)
    expect(PersistedEvent.last.visitor_identifier).to eq "abc"
  end

  it "stores the payload" do
    service.call(MockEvent.new)
    expect(PersistedEvent.last.payload).to eq("test" => "payload")
  end
end
