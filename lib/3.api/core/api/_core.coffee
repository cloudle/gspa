Wings.Api = {}

Wings.Api.isValidNode = (nodeObj) ->
  if Match.test(nodeObj.name, String) and nodeObj.name.length < 1
    return { valid: false, message: "invalid node name!" }

#  if Meteor.isServer
#    return { valid: false } if Model.ApiNode.findOne({name: nodeObj.name})

  return { valid: true }

Wings.Api.insertNode = (name, parentId) ->
  newChild = {name: name}
  newChild.parent = parentId if parentId

  validation = Wings.Api.isValidNode(newChild)
  if !validation.valid
    console.log validation.message
    return

  childId = Model.ApiNode.insert(newChild)
  Model.ApiNode.update(parentId, {$push: {childNodes: childId}}) if parentId

