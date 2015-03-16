Model.MetroSummary.before.insert (userId, doc) ->
  doc.creator = userId
  doc.createdAt = new Date()

Model.MetroSummary.before.update (userId, doc, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Model.MetroSummary.allow
  insert: (userId, doc)-> true if userId
  update: (userId, doc)-> true if userId
  remove: (userId, doc)-> true if userId