$ ->
  $("a[data-objection-id]").click (e) ->
    e.preventDefault()
    $(this).removeClass()
    showObjection($(this).data("objection-id"))

    $(".objection-pointer-arrow__active").attr("class","objection-pointer-arrow")
    $(this).parent().siblings("span").attr('class', 'objection-pointer-arrow__active')

showObjection = (objectionID) ->
  $objectionToShow = $(objectionID)
  $objectionToShow.siblings().hide()
  $objectionToShow.show()

  return false
