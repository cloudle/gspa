Wings.defineWidget "defaultLayout",
  rendered: ->
    $(window).resize ->
      Wings.Component.arrangeLayout()
      $(".nano").nanoScroller()

  destroyed: ->
    $(window).off("resize")