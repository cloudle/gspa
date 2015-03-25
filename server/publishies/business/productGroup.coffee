Model.ProductGroup.before.insert (userId, productGroup) ->
  productGroup.creator     = userId if userId
  productGroup.productList = []
  productGroup.createdAt   = new Date()

Model.ProductGroup.before.update (userId, productGroup, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Model.ProductGroup.allow
  insert: (userId, productGroup)-> true
  update: (userId, productGroup, fieldNames, modifier)-> true
  remove: (userId, productGroup)-> true