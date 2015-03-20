scope = logics.api = {}
setups.apiInits = []
setups.apiReactives = []

setups.apiInits.push ->
  console.log "yay!"

setups.apiReactives.push ->
  Session.set("currentApiNode", Model.ApiNode.findOne Session.get("currentApiNode")._id) if Session.get("currentApiNode")

#-----------------------------
Wings.Router.add
  template: 'api'
  onBeforeAction: ->
    if @ready()
      Wings.Router.setup(scope, setups.apiInits, "apiDocumentation")
      @next()
  data: ->
    console.log 'fired!'
    Wings.Router.setup(scope, setups.apiReactives)
    return {
      apiNodes: Model.ApiNode.find({parent: {$exists: false}})
      apiTechLeaves: Model.ApiMachineLeaf.find({})
      apiBizLeaves: Model.ApiHumanLeaf.find({})
    }