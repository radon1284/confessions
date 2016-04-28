class TrackingProxyEventSender
  def initialize(payload)
    self.payload = payload
  end

  def to_s
    ApplicationController
      .helpers
      .content_tag(
        "div",
        "",
        class: "js-tracking-proxy-event",
        data: { payload: payload.to_json }
      )
  end

  private

  attr_accessor :payload
end
