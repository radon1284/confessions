function initializeSlideout() {
  var slideout = new Slideout({
    'panel': document.getElementById('main-container'),
    'menu': document.getElementById('mobile-only-menu'),
    'padding': 256,
    'tolerance': 70
  });

  // Toggle button
  document.querySelector('.toggle-button').addEventListener('click', function() {
    slideout.toggle();
  });

  document.getElementById('slideout-close').addEventListener('click', function() {
    slideout.close();
  });
}
$(document).ready(initializeSlideout)
