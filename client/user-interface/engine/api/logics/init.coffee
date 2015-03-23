setups.apiInits = []
setups.apiReactives = []

#setups.apiInits.push (scope) ->

setups.apiReactives.push ->
  Session.set "currentApiNode", Model.ApiNode.findOne Session.get("currentApiNode")?._id ? {}