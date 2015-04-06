Wings.Enum.importTypes =
  property: 1
  method  : 2
  example : 3

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
  modifier.$set.finalPrice = (importObj.totalPrice - modifier.$set.depositCash) if _.contains(fieldNames, 'depositCash')


Model.Import.allow
  insert: (userId, importObj)-> true if Model.Warehouse.findOne(importObj.warehouse)
  update: (userId, importObj, fieldNames, modifier)->
    return false if !Wings.Validators.checkValidUpdateField(fieldNames, 'importUpdateFields')
#    return false if _.contains(fieldNames, 'provider') and !Model.Provider.findOne(modifier.$set.provider)
    return false if _.contains(fieldNames, 'depositCash') and modifier.$set.depositCash < 0
    return true
  remove: (userId, importObj)-> true