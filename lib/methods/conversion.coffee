#----Conversion----->
Meteor.methods
  insertConversion: (productId, unitId, conversion, barcode)->
    return {valid: false, error: 'Unit no found!'} if !unit = Schema.Unit.findOne unitId
    return {valid: false, error: 'Product no found!'} if !product = Schema.Product.findOne productId
    return {valid: false, error: 'Bracode is exist!'} if Schema.Conversion.findOne {barcode: barcode}

    if product.basicUnit
      return {valid: false, error: 'Đơn vị tính bị trùng với ĐVT cơ bản.'} if product.basicUnit is unitId
    else
      return {valid: false, error: 'Chưa tạo đơn vị tính cơ bản'}

    newConversion = {product: productId, unit: unitId, conversion: Convert.toNumber(conversion)}
    return {valid: false, error: 'Conversion is exist!'} if Schema.Conversion.findOne newConversion
    newConversion.barcode     = barcode
    newConversion.allowDelete = true
    newConversion.isRoot      = false

    insertResult = Wings.IRUS.insert(Schema.Conversion, newConversion, Wings.Validators.conversionInsert)
    if insertResult.valid
      Schema.Product.update productId, $addToSet: {conversion: insertResult.result}, $push: {unit: unitId}
      Schema.BranchProduct.find({product: productId}).forEach(
        (branchProduct)->
          Schema.BranchPrice.insert {branchProduct: branchProduct._id, conversion: insertResult.result, isRoot: false}
      )
    return insertResult

  insertDefaultConversion: (productId, branchId)->
    return {valid: false, error: 'Branch no found!'} if !Schema.Branch.findOne branchId
    return {valid: false, error: 'Product no found!'} if !product = Schema.Product.findOne productId
    return {valid: false, error: 'Product có BasicUnit!'} if product.basicUnit
    return {valid: false, error: 'Conversion is exist!'} if Schema.Conversion.findOne {product: productId}

    newConversion = {product: productId, conversion: 1, allowDelete: false, isRoot: true}
    insertResult = Wings.IRUS.insert(Schema.Conversion, newConversion, Wings.Validators.conversionInsertDefault)
    if insertResult.valid
      if Schema.Product.update(productId, $addToSet: {conversion: insertResult.result})
        Meteor.call 'insertBranchProduct', productId, branchId
    return insertResult

  updateConversion: (conversionId, model, fields)->
    if Schema.Conversion.findOne(conversionId)
      result = Wings.Validators.checkExistField(fields, "conversionUpdateFields")
      if result.valid then updateFields = result.data else return result

      if _.contains(updateFields, 'barcode')
        return {valid: false, error: 'barcode is exist!'} if Schema.Conversion.findOne({barcode: model.barcode})

      updateResult = Wings.IRUS.update(Schema.Conversion, conversionId, model, updateFields, Wings.Validators.conversionUpdate)
      return updateResult

  removeConversion: (conversionId)->
    if conversion = Schema.Conversion.findOne({_id: conversionId, allowDelete: true})
      result = Wings.IRUS.remove(Schema.Conversion, conversionId)

      if result.valid
        Schema.Product.update conversion.product, $pull: {conversion: conversionId, unit: conversion.unit}
        Schema.BranchPrice.find({conversion: conversionId}).forEach(
          (branchPrice) -> Schema.BranchPrice.remove branchPrice._id
        )

      return result

