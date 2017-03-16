function initializeSlideout() {
  var slideout = new Slideout({
    'panel': document.getElementById('main-container'),
    'menu': document.getElementById('mobile-only-menu'),
    'padding': 256,
    'touch': false,
    'tolerance': 70
  });

  // Toggle button
  $('.toggle-button').click(function() {
    slideout.toggle();
    // Events get removed after toggle so we must
    // set this within this function
    $("#slideout-close").click(function() {
      slideout.close();
    });
  });
}
$(document).ready(initializeSlideout)
