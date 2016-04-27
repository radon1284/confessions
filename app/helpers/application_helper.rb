module ApplicationHelper
  def tracking_proxy_configuration
    content_tag(
      "div",
      "",
      id: "tracking-proxy",
      data: data_for_tracking_proxy
    )
  end

  def send_event_to_tracking_proxy(payload)
    content_tag(
      "div",
      "",
      class: "js-tracking-proxy-event",
      data: { payload: payload.to_json }
    )
  end

  def data_for_tracking_proxy
    {
      environment: Rails.env,
      twitter: ENV["TWITTER_TRACKING_ID"],
      facebook: ENV["FACEBOOK_TRACKING_ID"],
      google_analytics: ENV["GOOGLE_ANALYTICS_TRACKING_ID"]
    }
  end
end
