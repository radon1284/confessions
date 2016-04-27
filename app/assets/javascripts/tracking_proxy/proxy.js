window.TrackingProxy = window.TrackingProxy || {};

window.TrackingProxy.Proxy = {
  init: function() {
    var configuration = this.getConfiguration();
    this.pickTrackers();
    this.trackers.forEach(function (tracker) {
      tracker.init(configuration);
    });
    this.processEventsFromDOM();
  },

  track: function(payload) {
    this.trackers.forEach(function (tracker) {
      tracker.track(payload);
    });
  },

  pickTrackers: function() {
    if (this.getEnvironment() === "production") {
      this.trackers = [
        window.TrackingProxy.TwitterTracker,
        window.TrackingProxy.FacebookTracker,
        window.TrackingProxy.GoogleAnalyticsTracker
      ];
    }
    else {
      this.trackers = [
        window.TrackingProxy.DummyTracker
      ];
    }
  },

  getEnvironment: function() {
    return this.getConfiguration().environment;
  },

  getConfiguration: function() {
    return document
      .getElementById("tracking-proxy")
      .dataset;
  },

  processEventsFromDOM: function() {
    var that = this;
    var elements = document.getElementsByClassName("js-tracking-proxy-event");
    Array.prototype.forEach.call(elements, function (element) {
      var payload = JSON.parse(element.getAttribute("data-payload"));
      that.track(payload);
    });
  }
};

document.addEventListener(
  'DOMContentLoaded',
  window.TrackingProxy.Proxy.init.bind(window.TrackingProxy.Proxy)
);
