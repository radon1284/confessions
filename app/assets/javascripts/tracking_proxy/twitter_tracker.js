window.TrackingProxy = window.TrackingProxy || {};

window.TrackingProxy.TwitterTracker = {
  init: function(configuration) {
    var script = document.createElement("script");
    script.type = "text/javascript";
    script.src = "//platform.twitter.com/oct.js";
    script.onload = function() {
      twttr.conversion.trackPid(
        configuration.twitter,
        { tw_sale_amount: 0, tw_order_quantity: 0 }
      );
    }
    document.body.appendChild(script);
  },

  track: function(payload) {

  }
};
