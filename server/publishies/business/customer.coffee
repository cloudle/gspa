Model.Customer.before.insert (userId, doc) ->
  doc.creator = userId if userId
  doc.createdAt = new Date()

Model.Customer.before.update (userId, doc, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Model.Customer.allow
  insert: (userId, customer)-> true
  update: (userId, customer, fieldNames, modifier)-> true
  remove: (userId, customer)-> true