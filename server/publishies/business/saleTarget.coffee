Model.SaleTarget.before.insert (userId, saleTarget) ->
  saleTarget.creator = userId if userId
  saleTarget.createdAt = new Date()

Model.SaleTarget.before.update (userId, saleTarget, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Model.SaleTarget.allow
  insert: (userId, saleTarget)-> true
  update: (userId, saleTarget, fieldNames, modifier)-> true
  remove: (userId, saleTarget)-> true