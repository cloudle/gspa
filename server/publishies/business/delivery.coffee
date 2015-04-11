Schema.Delivery.before.insert (userId, doc) ->
  doc.creator = userId if userId
  doc.createdAt = new Date()

Schema.Delivery.before.update (userId, doc, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Schema.Delivery.allow
  insert: (userId, delivery)-> true
  update: (userId, delivery, fieldNames, modifier)-> true
  remove: (userId, delivery)-> true