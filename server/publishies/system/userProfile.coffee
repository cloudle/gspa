Model.UserProfile.before.insert (userId, doc) ->
  doc.createdAt = new Date()

Model.UserProfile.before.update (userId, doc, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()

Model.UserProfile.allow
  insert: (userId, doc)-> true if userId
  update: (userId, doc)-> true if userId
  remove: (userId, doc)-> true if userId




