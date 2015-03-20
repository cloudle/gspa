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
  insert: (userId, importObj)-> Wings.Import.isValidImport(importObj).valid if userId
  update: (userId, importObj, fieldNames, modifier)->
    if userId
      if _.contains(fieldNames, "description")
        console.log Wings.Import.isValidDescription(modifier.$set.description).valid
        return false if !Wings.Import.isValidDescription(modifier.$set.description).valid
      if _.contains(fieldNames, "depositCash")
        return false if !Wings.Import.isValidDepositCash(modifier.$set.depositCash).valid
      if _.contains(fieldNames, "provider")
        return false if !Model.Provider.findOne(modifier.$set.provider)
      return true
  remove: (userId, importObj)-> true if userId