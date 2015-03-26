Wings.defineWidget 'apiNodeTree',
  currentNode: -> Session.get('currentApiNode')

  events:
    "click li.api-node": (event, template) ->
      Session.set "currentApiNode", @;
      Session.set "currentApiRoot", @ unless @parent
      event.stopPropagation()
    "click .remove-node": (event, template) ->
      smartEmptyCurrentSelection(@) if Session.get("currentApiNode")
      Wings.Api.removeNode(@_id)

    "keyup input[name='apiFilter']": (event, template) ->
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

#----------------------------------------------
smartEmptyCurrentSelection = (instance) ->
  currentNode = Session.get("currentApiNode")
  loop
    (Session.set "currentApiNode"; console.log "session cleaned"; break) if currentNode._id == instance._id
    break if !currentNode.parent

    currentNode = Model.ApiNode.findOne(currentNode.parent)
    break if !currentNode