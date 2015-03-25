Model.Import.before.insert (userId, importObj) ->
  importObj.discountCash = 0
  importObj.depositCash  = 0
  importObj.totalPrice   = 0
  importObj.finalPrice   = 0
  importObj.creator      = userId
  importObj.createdAt    = new Date()

Model.Import.before.update (userId, importObj, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Model.Import.allow
  insert: (userId, importObj)-> true
  update: (userId, importObj, fieldNames, modifier)-> true
  remove: (userId, importObj)-> true