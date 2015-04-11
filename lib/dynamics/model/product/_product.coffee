class Model.Product
  constructor: (doc) -> @[key] = value for key, value of doc

  @insert: (name, description = null)->
    newProduct = {name: name}
    newProduct.description = description if description
    Wings.IRUS.insert(Schema.Product, newProduct, Wings.Validators.productInsert)

  insert: ()->
    return {valid: false, error: 'This record is created'} if @_id

    newProduct = {name: @name}
    newProduct.description = @description if @description
    insertResult = Wings.IRUS.insert(Schema.Product, newProduct, Wings.Validators.productInsert)

    @_id = insertResult.result if insertResult.valid
    return insertResult

  update: (fields)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    result = Wings.Validators.checkExistField(fields, "productUpdateFields")
    if result.valid then updateFields = result.data else return result

    Wings.IRUS.update(Schema.Product, @_id, @, updateFields, Wings.Validators.productUpdate)

  remove: -> Wings.IRUS.remove(Schema.Product, @_id)

  insertBranchProduct: (branchId)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    newBranchProduct = {branch: branchId, product: @_id}
    insertResult = Wings.IRUS.insert(Schema.BranchProduct, newBranchProduct, Wings.Validators.branchProductInsert)

    if insertResult.valid
      newBranchPrice = {branchProduct: insertResult.result, isRoot: true}
      if @basicUnit and @conversion.length > 0
        for item, index in @conversion
          newBranchPrice.isRoot     = if index is 0 then true else false
          newBranchPrice.conversion = item
          Wings.IRUS.insert(Schema.BranchPrice, newBranchPrice, Wings.Validators.branchPriceInsert)
      else
        Wings.IRUS.insert(Schema.BranchPrice, newBranchPrice, Wings.Validators.branchPriceInsert)

    return insertResult

  setBasicUnit: (unitId)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    if @basicUnit
      return {valid: false, error: 'basicUnit trùng lắp'} if @basicUnit is unitId
      return {valid: false, error: 'không thể sửa đổi basicUnit'} if @conversion.length > 1

    updateResult = Wings.IRUS.setField(Schema.Product, @, 'basicUnit', unitId, Wings.Validators.productBasicUnit)
    if updateResult.valid
      Schema.Conversion.remove(@conversion[0]) if @conversion?.length is 1
  #    Meteor.call 'productSetBasicUnit', @_id, unitId

      newConvention = {product: @_id, unit: unitId, conversion: 1}
      insertResult = Wings.IRUS.insert(Schema.Conversion, newConvention, Wings.Validators.conversionInsert)
      if insertResult.valid
        Schema.BranchProduct.find({product: @_id}).forEach(
          (branchProduct)->
            Schema.BranchPrice.find({branchProduct: branchProduct._id, isRoot: true}).forEach(
              (branchPrice) -> Schema.BranchPrice.update branchPrice._id, $set:{conversion: insertResult.result}
            )
        )

  insertConversion: (unitId, conversion)->
    return {valid: false, error: 'This _id is required!'} if !@_id
    if @basicUnit
      return {valid: false, error: 'Đơn vị tính bị trùng với ĐVT cơ bản.'} if @basicUnit is unitId
    else
      return {valid: false, error: 'Chưa tạo đơn vị tính cơ bản'}

    newConversion = {product: @_id, unit: unitId, conversion: conversion}
    insertResult = Wings.IRUS.insert(Schema.Conversion, newConversion, Wings.Validators.conversionInsert)
    if insertResult.valid
      Schema.BranchProduct.find({product: @_id}).forEach(
        (branchProduct)->
          newBranchPrice = {branchProduct: branchProduct._id, conversion: insertResult.result, isRoot: false}
          console.log Wings.IRUS.insert(Schema.BranchPrice, newBranchPrice, Wings.Validators.branchPriceInsert)
      )