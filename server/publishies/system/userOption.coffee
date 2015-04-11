Schema.UserOption.before.insert (userId, userOption) ->
  userOption.createdAt = new Date()

Schema.UserOption.before.update (userId, userOption, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()

Schema.UserOption.allow
  insert: (userId, userOption)-> true
  update: (userId, userOption, fieldNames, modifier)-> true
  remove: (userId, userOption)-> true
