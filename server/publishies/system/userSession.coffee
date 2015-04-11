Schema.UserSession.before.insert (userId, userSession)->
  userSession.createdAt = new Date()

Schema.UserSession.before.update (userId, userSession, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()

Schema.UserSession.allow
  insert: (userId, userSession)-> true
  update: (userId, userSession, fieldNames, modifier)-> true
  remove: (userId, userSession)-> true



