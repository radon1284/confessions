var showObjection;

$(function() {
  return $("a[data-objection-id]").click(function(e) {
    e.preventDefault();
    $(this).removeClass();
    showObjection($(this).data("objection-id"));
    $(".objection-pointer-arrow__active").attr("class", "objection-pointer-arrow");
    return $(this).parent().siblings("span").attr('class', 'objection-pointer-arrow__active');
  });
});

showObjection = function(objectionID) {
  var $objectionToShow;
  $objectionToShow = $(objectionID);
  $objectionToShow.siblings().hide();
  $objectionToShow.show();
  return false;
};
