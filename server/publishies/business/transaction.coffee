Schema.Transaction.before.insert (userId, transaction) ->
  transaction.creator = userId if userId
  transaction.createdAt = new Date()

Schema.Transaction.before.update (userId, transaction, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Schema.Transaction.allow
  insert: (userId, transaction)-> true
  update: (userId, transaction, fieldNames, modifier)-> true
  remove: (userId, transaction)-> true