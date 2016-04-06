require "rails_helper"

describe EventPublisher do
  class EventMock
  end

  let!(:event) { EventMock.new }

  describe "publish" do
    context "when there are no handlers" do
      before do
        EventPublisher.clear_handlers(EventMock)
      end

      it "does nothing" do
        expect { EventPublisher.publish(event) }
          .not_to raise_error
      end
    end

    context "when there are two handlers" do
      let!(:first_handler) { spy }
      let!(:second_handler) { spy }

      before do
        EventPublisher.clear_handlers(EventMock)
        EventPublisher.push_handler(EventMock, first_handler)
        EventPublisher.push_handler(EventMock, second_handler)
      end

      it "calls both handlers" do
        EventPublisher.publish(event)
        expect(first_handler).to have_received(:call).with(event)
        expect(second_handler).to have_received(:call).with(event)
      end
    end
  end
end
