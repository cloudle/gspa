Model.Customer.before.insert (userId, doc) ->
  doc.creator = userId
  doc.createdAt = new Date()

Model.Customer.before.update (userId, doc, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Model.Customer.allow
  insert: (userId, user)-> true
  update: (userId, user)-> true
  remove: (userId, user)-> true