Wings.Api = {}
Model.ApiNode = new Meteor.Collection 'apiNodes'
Model.ApiLeaf = new Meteor.Collection 'apiLeaves'

Wings.Api.insertNode = (name) ->
  Model.ApiNode.insert({name: name})

Wings.Api.insertLeaf = (name) ->
  Model.ApiLeaf.insert({name: name})

