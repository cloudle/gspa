Schema.SaleTarget.before.insert (userId, saleTarget) ->
  saleTarget.creator = userId if userId
  saleTarget.createdAt = new Date()

Schema.SaleTarget.before.update (userId, saleTarget, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Schema.SaleTarget.allow
  insert: (userId, saleTarget)-> true
  update: (userId, saleTarget, fieldNames, modifier)-> true
  remove: (userId, saleTarget)-> true