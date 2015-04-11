class Model.Product.Conversion
  constructor: (doc) -> @[key] = value for key, value of doc
  findProduct: -> Schema.Product.findOne @product
  findUnit: -> Schema.Unit.findOne @unit

  @insert: (productId, unitId, conversion = 1)->
    newConversion = {product: productId, unit: unitId, conversion: conversion}
    insertResult = Wings.IRUS.insert(Schema.Conversion, newConversion, Wings.Validators.conversionInsert)
    if insertResult.valid
      Schema.BranchProduct.find({product: productId}).forEach(
        (branchProduct)->
          newBranchPrice = {branchProduct: branchProduct._id, conversion: insertResult.valid, isRoot: false}
          Wings.IRUS.insert(Schema.BranchPrice, newBranchPrice, Wings.Validators.branchPriceInsert)
      )
    return insertResult

  insert: ()->
    return {valid: false, error: 'This record is created'} if @_id

    newConversion = {product: @product, unit: @unit, conversion: @conversion}
    insertResult = Wings.IRUS.insert(Schema.Conversion, newConversion, Wings.Validators.conversionInsert)

    @_id = insertResult.result if insertResult.valid
    return insertResult

  update: (fields)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    result = Wings.Validators.checkExistField(fields, "conversionUpdateFields")
    if result.valid then updateFields = result.data else return result

    Wings.IRUS.update(Schema.Conversion, @_id, @, updateFields, Wings.Validators.conversionUpdate)

  remove: ->
    Wings.IRUS.remove(Schema.Conversion, @_id)
