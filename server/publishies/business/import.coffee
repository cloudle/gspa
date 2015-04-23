Schema.Import.allow
  insert: (userId, importObj)-> true if Schema.Warehouse.findOne(importObj.warehouse)
  update: (userId, importObj, fieldNames, modifier)->
#    return false if !Wings.Validators.checkValidUpdateField(fieldNames, 'importUpdateFields')
#    return false if _.contains(fieldNames, 'provider') and !Schema.Provider.findOne(modifier.$set.provider)
#    return false if _.contains(fieldNames, 'depositCash') and modifier.$set.depositCash < 0
    return true
  remove: (userId, importObj)-> true