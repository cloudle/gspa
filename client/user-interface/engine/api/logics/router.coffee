scope = logics.api = {}

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
      apiNodes: Model.ApiNode.find({parent: {$exists: false}}, {sort: {name: 1}})
      apiTechLeaves: Model.ApiMachineLeaf.find({})
      apiBizLeaves: Model.ApiHumanLeaf.find({})
    }