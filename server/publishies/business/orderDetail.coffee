Model.OrderDetail.before.insert (userId, orderDetail) ->
  orderDetail.creator = userId if userId
  orderDetail.createdAt = new Date()

Model.OrderDetail.before.update (userId, orderDetail, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Model.OrderDetail.allow
  insert: (userId, orderDetail)-> true
  update: (userId, orderDetail, fieldNames, modifier)-> true
  remove: (userId, orderDetail)-> true