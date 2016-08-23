$(document).ready(function() {
  preloaderFadeOutTime = 500;
  maxLoaderTime = 1500;

  function hidePreloader() {
    var preloader = $('.spinner-wrapper');
    preloader.fadeOut(preloaderFadeOutTime);
    preloader.hide();
  }

  $(window).on('load', (function() {
    hidePreloader();
  }));

  setTimeout(hidePreloader, maxLoaderTime)
});
