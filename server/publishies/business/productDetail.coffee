Model.ProductDetail.before.insert (userId, productDetail) ->
  productDetail.creator = userId if userId
  productDetail.createdAt = new Date()

Model.ProductDetail.before.update (userId, productDetail, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Model.ProductDetail.allow
  insert: (userId, productDetail)-> true
  update: (userId, productDetail, fieldNames, modifier)-> true
  remove: (userId, productDetail)-> true