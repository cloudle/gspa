Wings.defineApp 'apiDocumentation',
  events:
    "keypress input[name='apiFilter']": (event, template)->
      if event.which is 13
        $target = $(event.currentTarget)
        if (!Session.get("currentApiNode") || event.shiftKey)
          console.log 'this is with Ctrl'
          Wings.Api.insertNode($target.val())
          $target.val('')
        else
          console.log 'this is without Ctrl'
          Wings.Api.insertNode($target.val(), Session.get("currentApiNode")._id)
          $target.val('')


    "click li": (event, template) -> Session.set "currentApiNode", @