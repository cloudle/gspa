Model.Provider.before.insert (userId, provider) ->
  provider.creator = userId if userId
  provider.createdAt = new Date()

Model.Provider.before.update (userId, provider, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Model.Provider.allow
  insert: (userId, provider)-> true
  update: (userId, provider, fieldNames, modifier)-> true
  remove: (userId, provider)-> true