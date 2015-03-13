Wings.defineApp 'apiDocumentation',
  events:
    "keypress input[name='apiFilter']": (event, template)->
      if event.which is 13
        $target = $(event.currentTarget)
        Wings.Api.insertNode($target.val())
        $target.val('')