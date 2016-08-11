// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ujs
//= require highlightjs
//= require slideout.js/slideout.js
//= require social-share-kit
//= require widow-tamer.js
//= require_tree .

// Syntax highlighting with highlight.js
hljs.initHighlightingOnLoad();

// Widow Tamer script
$(document).ready(function() {
  wt.fix({elements: 'h1,h2,h3,h4,p,li',
          method: 'nbsp'
  })
});

$(document).ready(function($) {
  $(".clickable-row").click(function() {
    window.document.location = $(this).data("href");
  });
});

function showTableOfContents() {
  $("#table_of_contents").show();
}
