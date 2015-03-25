Model.Sale.before.insert (userId, sale) ->
  delete sale.buyer if !sale.buyer
  sale.seller = userId if sale.seller
  sale.creator = userId if userId
  sale.createdAt = new Date()

Model.Sale.before.update (userId, sale, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Model.Sale.allow
  insert: (userId, sale)-> true
  update: (userId, sale, fieldNames, modifier)-> true
  remove: (userId, sale)-> true