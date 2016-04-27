window.TrackingProxy = window.TrackingProxy || {};

window.TrackingProxy.DummyTracker = {
  init: function(_configuration) {
    this.events = [];
  },

  track: function(payload) {
    this.events.push(payload);
  }
};
