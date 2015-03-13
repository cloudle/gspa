Wings.Api = {}

Wings.Api.insertNode = (name) ->
  Model.ApiNode.insert({name: name})

Wings.Api.insertLeaf = (name) ->
  Model.ApiLeaf.insert({name: name})