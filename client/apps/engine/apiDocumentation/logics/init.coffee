scope = Wings.logics.api = {}
Wings.setups.apiInit = []

#-----------------------------
Wings.Router.add
  template: 'apiDocumentation'
  path: '/api'
  data: ->
    return {
      apiNodes: Model.ApiNode.find({})
      apiLeaves: Model.ApiLeaf.find({})
    }