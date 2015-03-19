Wings.ImportDetail = {}
Wings.ImportDetail.nextCode = ()->
Wings.ImportDetail.changStatus = ()->

Wings.ImportDetail.isValidInsert= (importDetailObj)->
  if Meteor.isClient
    return { valid: false, message: "you are not logged in" } if !Meteor.userId()

  if Match.test(importDetailObj.import, String)
    return { valid: false, message: "invalid importDetail import!" }

  if Match.test(importDetailObj.product, String)
    return { valid: false, message: "invalid importDetail provider!" }

  if Match.test(importDetailObj.quality, Number) and importDetailObj.quality > 0
    return { valid: false, message: "invalid importDetail importDetailCode!" }

  if Match.test(importDetailObj.price, Number) and importDetailObj.price > 0
    return { valid: false, message: "invalid importDetail warehouse!" }

  return { valid: true }

Wings.ImportDetail.isValidQuality = (quality, importDetailId)->
  if Meteor.isClient
    return { valid: false, message: "you are not logged in" } if !Meteor.userId()

  if Match.test(importDetailId, String)
    return { valid: false, message: "invalid importDetail id!" }

  if Match.test(quality Number) and quality > 0
    return { valid: false, message: "invalid importDetail quality!" }

  return { valid: true }

Wings.ImportDetail.isValidPrice = (price, importDetailId)->
  if Meteor.isClient
    return { valid: false, message: "you are not logged in" } if !Meteor.userId()

  if Match.test(importDetailId, String)
    return { valid: false, message: "invalid importDetail id!" }

  if Match.test(price Number) and quality > 0
    return { valid: false, message: "invalid importDetail price!" }

  return { valid: true }

Wings.ImportDetail.isValidRemove = (importDetailId)->
  if Meteor.isClient
    return { valid: false, message: "you are not logged in" } if !Meteor.userId()

  if Match.test(importDetailId, String)
    return { valid: false, message: "invalid importDetail id!" }

  return { valid: true }



Wings.ImportDetail.insert = (productId, quality, price, importId)->
  importDetail = {product: productId, quality: quality, price: price, import: importId}
  validation = Wings.ImportDetail.isValidInsert(importDetail)
  if !validation.valid
    console.log validation.message
    return

  importDetailId = Model.ImportDetail.insert(importDetail)

Wings.ImportDetail.updateQuality = (quality, importDetailDetailId)->
  validation = Wings.ImportDetail.isValidDescription(description, importDetailDetailId)
  if !validation.valid
    console.log validation.message
    return

  Model.ImportDetail.update importDetailDetailId, $set: {quality: quality}

Wings.ImportDetail.updatePrice = (price, importDetailDetailId)->
  validation = Wings.ImportDetail.isValidProvider(description, importDetailDetailId)
  if !validation.valid
    console.log validation.message
    return

  Model.ImportDetail.update importDetailDetailId, $set: {price: price}

Wings.ImportDetail.remove = (importDetailDetailId)->
  validation = Wings.ImportDetail.isValidRemove(importDetailDetailId)
  if !validation.valid
    console.log validation.message
    return

  Model.ImportDetail.remove importDetailDetailId