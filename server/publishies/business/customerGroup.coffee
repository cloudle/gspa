Schema.CustomerGroup.before.insert (userId, doc) ->
  doc.creator      = userId if userId
  doc.createdAt    = new Date()
  doc.customerList = []

Schema.CustomerGroup.before.update (userId, doc, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Schema.CustomerGroup.allow
  insert: (userId, customerGroup)-> true
  update: (userId, customerGroup, fieldNames, modifier)-> true
  remove: (userId, customerGroup)-> true