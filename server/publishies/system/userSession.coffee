Model.UserSession.before.insert (userId, doc)->
  doc.createdAt = new Date()

Model.UserSession.before.update (userId, doc, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()

Model.UserSession.allow
  insert: (userId, user)-> true
  update: (userId, user)-> true
  remove: (userId, user)-> true



