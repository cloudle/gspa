scope = Wings.logics.api = {}
Wings.setups.apiInit = []

#-----------------------------
Wings.Router.add
  template: 'apiDocumentation'
  path: '/api'
  data: ->
    return {
      apiNodes: Model.ApiNode.find({parent: {$exists: false}}, {sort:{name: 1}} )
      apiTechLeaves: Model.ApiMachineLeaf.find({})
      apiBizLeaves: Model.ApiHumanLeaf.find({})
    }