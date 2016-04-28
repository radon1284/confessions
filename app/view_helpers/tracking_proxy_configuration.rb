class TrackingProxyConfiguration
  def to_s
    ApplicationController
      .helpers
      .content_tag(
        "div",
        "",
        id: "tracking-proxy",
        data: data_for_tracking_proxy
      )
  end

  private

  def data_for_tracking_proxy
    {
      environment: Rails.env,
      twitter: ENV["TWITTER_TRACKING_ID"],
      facebook: ENV["FACEBOOK_TRACKING_ID"],
      google_analytics: ENV["GOOGLE_ANALYTICS_TRACKING_ID"]
    }
  end
end
