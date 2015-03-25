Model.Option.before.insert (userId, option) ->
  option.creator = userId if userId
  option.createdAt = new Date()

Model.Option.before.update (userId, option, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Model.Option.allow
  insert: (userId, option)-> true
  update: (userId, option, fieldNames, modifier)-> true
  remove: (userId, option)-> true