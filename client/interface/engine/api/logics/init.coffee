setups.apiInits = []
setups.apiReactives = []

setups.apiInits.push (scope) ->
  scope.insertingMember = new ReactiveVar(false)
  scope.insertingMethod = new ReactiveVar(false)

setups.apiReactives.push ->
  Session.set "currentApiNode", Model.ApiNode.findOne Session.get("currentApiNode")?._id ? {}