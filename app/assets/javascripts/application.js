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
//= require slickquiz.js
//= require_tree .

// Syntax highlighting with highlight.js
hljs.initHighlightingOnLoad();

function showTableOfContents() {
  $("#table_of_contents").show();
}
$(function(){
  $('#slickQuiz').slickQuiz({
                            json: quizJSON,
                            backButtonText: '< Back ',
                            displayQuestionNumber: false,
                            checkAnswerText: '',
                            disableRanking: true,
                            animationCallbacks: {
                              nextQuestion: function () {
                                $('body').animate({
                                  scrollTop: $('#slickQuiz').offset().top - 20
                                }, 'fast');
                              }
                            }

  });
});
