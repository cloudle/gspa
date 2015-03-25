Model.Product.before.insert (userId, product) ->
  product.creator = userId if userId
  product.createdAt = new Date()

Model.Product.before.update (userId, product, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Model.Product.allow
  insert: (userId, product)-> true
  update: (userId, product, fieldNames, modifier)-> true
  remove: (userId, product)-> true