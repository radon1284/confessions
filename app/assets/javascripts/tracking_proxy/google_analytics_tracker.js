window.TrackingProxy = window.TrackingProxy || {};

window.TrackingProxy.GoogleAnalyticsTracker = {
  init: function(configuration) {
    this.runAnalyticsSnippet();
    ga('create', configuration.googleAnalytics, 'auto');
    ga('require', 'ecommerce');
    ga('send', 'pageview');
  },

  track: function(payload) {
    if (payload.event === 'pdf_preview_downloaded') {
      ga('send', {
        hitType: 'event',
        eventCategory: 'PDFPreview',
        eventAction: 'download',
        eventLabel: payload.book_title
      },
      {
        'transport': 'beacon',
      });
    }

    if (payload.event === 'order_completed') {
      ga('ecommerce:addTransaction', {
        id: payload.order_id,
        revenue: payload.total,
        currency: payload.currency
      });

      payload.items.forEach(function (item) {
        ga('ecommerce:addItem', {
          id: payload.order_id,
          name: item.name,
          price: item.price,
          quantity: 1,
          currency: item.currency,
          sku: item.name
        });
      });

      ga('ecommerce:send');
    }
  },

  runAnalyticsSnippet: function() {
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
  }
};
