removeChildNodes = (childNodes)->
  Model.ApiNode.find({_id: {$in:childNodes}}).forEach(
    (apiNode)->
      console.log apiNode.name
      Model.ApiNode.remove apiNode._id
      if apiNode.childNodes
        removeChildNodes(apiNode.childNodes)
  )


Model.ApiNode.after.remove (userId, doc) ->
  Model.ApiNode.update(doc.parent, {$pull: {childNodes: doc._id}}) if doc.parent
  removeChildNodes(doc.childNodes) if doc.childNodes

  #TODO Remove related leaves


Model.ApiNode.allow
  insert: (userId, apiNode) -> Wings.Api.isValidNode(apiNode).valid
  update: (userId, apiNode, fieldNames, modifier)->
    if _.contains(fieldNames, "childNodes")
      if Model.ApiNode.findOne(modifier.$push.childNodes) then return true else return false
    return true
  remove: (userId, apiNode)-> true