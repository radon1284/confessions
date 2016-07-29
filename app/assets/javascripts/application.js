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
//= require_tree .

// Syntax highlighting with highlight.js
hljs.initHighlightingOnLoad();

function showTableOfContents() {
  $("#table_of_contents").show();
}

function showObjection(objectionID) {
  $objectionToShow = $(objectionID);
  $objectionToShow.siblings().hide();
  $objectionToShow.show();
  return false;
}
