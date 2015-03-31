recursiveRemoveChild = (childNodes)->
  Model.ApiNode.find({_id: {$in:childNodes}}).forEach (apiNode) ->
    Model.ApiNode.remove apiNode._id
    Model.ApiHumanLeaf.remove({parent: apiNode._id})
    Model.ApiMachineLeaf.remove({parent: apiNode._id})

    recursiveRemoveChild(apiNode.childNodes) if apiNode.childNodes

Model.ApiNode.after.remove (userId, doc) ->
  Model.ApiNode.update(doc.parent, {$pull: {childNodes: doc._id}}) if doc.parent
  Model.ApiHumanLeaf.remove({parent: doc._id})
  Model.ApiMachineLeaf.remove({parent: doc._id})
  recursiveRemoveChild(doc.childNodes) if doc.childNodes

Model.ApiNode.allow
  insert: (userId, apiNode) -> Wings.Api.isValidNode(apiNode).valid
  update: (userId, apiNode, fieldNames, modifier)->
    if _.contains(fieldNames, "childNodes")
      if Model.ApiNode.findOne(modifier.$push.childNodes) then return true else return false
    return true
  remove: (userId, apiNode)-> true
#
#Model.ApiMachineLeaf.allow
#  insert: (userId, apiMachineLeaf) -> true
#  update: (userId, apiMachineLeaf, fieldNames, modifier)-> true
#  remove: (userId, apiMachineLeaf)-> true
#
#Model.ApiHumanLeaf.allow
#  insert: (userId, apiHumanLeaf) -> true
#  update: (userId, apiHumanLeaf, fieldNames, modifier)-> true
#  remove: (userId, apiHumanLeaf)-> true
