Model.Order.before.insert (userId, order) ->
  order.creator = userId if userId
  order.createdAt = new Date()

Model.Order.before.update (userId, order, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Model.Order.allow
  insert: (userId, order)-> true
  update: (userId, order, fieldNames, modifier)-> true
  remove: (userId, order)-> true