Schema.ImportDetail.allow
  insert: (userId, importDetail)-> true if Schema.Import.findOne(importDetail.import)
  update: (userId, importDetail, fieldNames, modifier)->
#    return false if !Wings.Validators.checkValidUpdateField(fieldNames, 'importDetailUpdateFields')
#    return false if _.contains(fieldNames, 'quality') and modifier.$set.quality < 0
#    return false if _.contains(fieldNames, 'price') and modifier.$set.price < 0
    true
  remove: (userId, importDetail)-> true