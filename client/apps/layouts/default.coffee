Wings.defineWidget "defaultLayout",
  rendered: ->
    $(window).resize ->
      Wings.Component.arrangeLayout()

  destroyed: ->
    $(window).off("resize")