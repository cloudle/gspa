Schema.Product.before.insert (userId, product) ->
  product.creator = userId if userId
  product.createdAt = new Date()

  product.productGroup = []
  product.conversion   = []

  product.availableQuality = product.inOderQuality = product.inStockQuality = product.saleQuality =
    product.returnSaleQuality = product.importQuality = product.returnImportQuality = 0

Schema.Product.before.update (userId, product, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Schema.Product.allow
  insert: (userId, product)-> true
  update: (userId, product, fieldNames, modifier)-> true
  remove: (userId, product)-> true