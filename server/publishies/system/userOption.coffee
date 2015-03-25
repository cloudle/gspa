Model.UserOption.before.insert (userId, userOption) ->
  userOption.createdAt = new Date()

Model.UserOption.before.update (userId, userOption, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()

Model.UserOption.allow
  insert: (userId, userOption)-> true
  update: (userId, userOption, fieldNames, modifier)-> true
  remove: (userId, userOption)-> true
