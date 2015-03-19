Model.ApiNode.after.remove (userId, doc) ->
  Model.ApiNode.update(doc.parent, {$pull: {childNodes: doc._id}}) if doc.parent
#  Model.ApiNode.remove(child) for child in doc.childNodes

  #TODO Remove related leaves

Model.ApiNode.allow
  insert: (userId, apiNode) -> Wings.Api.isValidNode(apiNode).valid
  update: (userId, apiNode, fieldNames, modifier)->
    if _.contains(fieldNames, "childNodes")
      if Model.ApiNode.findOne(modifier.$push.childNodes) then return true else return false
    return true
  remove: (userId, apiNode)-> true