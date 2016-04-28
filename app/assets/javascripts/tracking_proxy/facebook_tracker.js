window.TrackingProxy = window.TrackingProxy || {};

window.TrackingProxy.FacebookTracker = {
  init: function(configuration) {
    this.runFacebookSnippet();
    fbq('init', configuration.facebook);
    fbq('track', 'PageView');
  },

  track: function(payload) {
    if (payload.event === 'order_completed') {
      fbq(
        'track',
        'Purchase',
        { currency: payload.currency, value: payload.total }
      );
    }
  },

  runFacebookSnippet: function() {
    !function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?
    n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;
    n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
    t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,
    document,'script','//connect.facebook.net/en_US/fbevents.js');
  }
};
