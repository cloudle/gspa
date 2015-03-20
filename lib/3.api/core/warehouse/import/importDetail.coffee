Import = Wings.Warehouse.Import


Import.isValidInsert= (importDetailObj)->
  if Meteor.isClient
    return { valid: false, message: "you are not logged in" } if !Meteor.userId()

  if !Match.test(importDetailObj.import, String)
    return { valid: false, message: "invalid importDetail import!" }

  if !Match.test(importDetailObj.product, String)
    return { valid: false, message: "invalid importDetail product!" }

  if !Match.test(importDetailObj.quality, Number) and importDetailObj.quality <= 0
    return { valid: false, message: "invalid importDetail quality!" }

  if !Match.test(importDetailObj.price, Number) and importDetailObj.price <= 0
    return { valid: false, message: "invalid importDetail price!" }

  return { valid: true }

Import.isValidUpdate = (updateImportDetailObj)->
  if Meteor.isClient
    return { valid: false, message: "you are not logged in" } if !Meteor.userId()

  if !Match.test(updateImportDetailObj._id, String)
    return { valid: false, message: "invalid importDetail id!" }

  if updateImportDetailObj.quality
    if !Match.test(updateImportDetailObj.quality, Number) and updateImportDetailObj.quality <= 0
      return { valid: false, message: "invalid importDetail quality!" }

  if updateImportDetailObj.price
    if !Match.test(updateImportDetailObj.price, Number) and updateImportDetailObj.price <= 0
      return { valid: false, message: "invalid importDetail price!" }

  return { valid: true }

Import.isValidRemove = (importDetailId)->
  if Meteor.isClient
    return { valid: false, message: "you are not logged in" } if !Meteor.userId()

  if !Match.test(importDetailId, String)
    return { valid: false, message: "invalid importDetail id!" }

  return { valid: true }




Import.addImportProduct = (productId, quality, price, importId)->
  importDetail = {product: productId, quality: quality, price: price, import: importId}
  validation = Import.isValidInsert(importDetail)
  if !validation.valid
    console.log validation.message
    return

  Model.ImportDetail.insert(importDetail)

Import.updateImportProduct = (quality, price, importDetailId)->
  updateImportDetail = {}
  updateImportDetail.quality = quality if quality
  updateImportDetail.price = price if price

  validation = Import.isValidUpdate(updateImportDetail)
  if !validation.valid
    console.log validation.message
    return

  delete updateImportDetail._id
  Model.ImportDetail.update importDetailId, $set: updateImportDetail if _.keys(updateImportDetail).length > 0

Import.removeImportProduct = (importDetailId)->
  validation = Import.isValidRemove(importDetailId)
  if !validation.valid
    console.log validation.message
    return

  Model.ImportDetail.remove importDetailId