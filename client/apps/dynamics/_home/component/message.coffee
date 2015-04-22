Wings.defineWidget 'message',
  avatarImg: -> "avatars/#{@creator}.jpg"
  rendered: ->
    $(".messenger-scroller").nanoScroller()
    $(".messenger-scroller").nanoScroller({ scroll: 'bottom' })
