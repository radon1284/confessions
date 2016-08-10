(function(){
  var showObjection = function(objectionID) {
    var $objectionToShow;
    $objectionToShow = $(objectionID);
    $objectionToShow.siblings().hide();
    $objectionToShow.show();
    return false;
  };

  $(function() {
    $(".js-selectable-objection").click(function(e) {
      e.preventDefault();
      $(".js-selectable-objection").removeClass("selectable-objection--selected");
      $(this).addClass("selectable-objection--selected");
      showObjection($(this).data("objection-id"));
    });
  });
})();
