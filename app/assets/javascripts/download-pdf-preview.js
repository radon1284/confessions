$(function() {
  $(".js-download-pdf-preview").click(function(e) {
    TrackingProxy.Proxy.track({
      event: "pdf_preview_downloaded",
      slug: $(this).data("slug")
    });
  });
});
