Model.ImportDetail.before.insert (userId, doc) ->
  doc.creator = userId
  doc.createdAt = new Date()

Model.ImportDetail.before.update (userId, doc, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Model.ImportDetail.allow
  insert: (userId, doc)-> true if userId
  update: (userId, doc)-> true if userId
  remove: (userId, doc)-> true if userId