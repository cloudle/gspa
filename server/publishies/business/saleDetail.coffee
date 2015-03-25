Model.SaleDetail.before.insert (userId, saleDetail) ->
  saleDetail.creator = userId if userId
  saleDetail.createdAt = new Date()

Model.SaleDetail.before.update (userId, saleDetail, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Model.SaleDetail.allow
  insert: (userId, saleDetail)-> true
  update: (userId, saleDetail, fieldNames, modifier)-> true
  remove: (userId, saleDetail)-> true