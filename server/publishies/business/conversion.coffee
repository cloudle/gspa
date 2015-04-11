Schema.Conversion.allow
  insert: (userId, conversion)->
    cloneSource = {}; cloneSource[key] = value for key, value of conversion
    isValidSchema = Wings.IRUS.validate(cloneSource, Wings.Validators.conversionInsert)
    console.log isValidSchema

#    if isValidSchema.valid
#      product = Schema.Product.findOne(conversion.product)
#      unit = Schema.Unit.findOne(conversion.unit)
#      return false if !product or !unit
#
#      if product.basicUnit is unit._id
#        Schema.BranchProduct.find({product: product._id}).forEach(
#          (branchProduct)->
#            Schema.BranchPrice.update({branchProduct: branchProduct._id, isRoot: true}, {$set:{conversion: conversion._id}}, {multi: true})
#        )
#      else
#        Schema.BranchProduct.find({product: product._id}).forEach(
#          (branchProduct)->
#            newBranchPrice = {branchProduct: branchProduct._id, conversion: conversion._id, isRoot: false}
#            Wings.IRUS.insert(Schema.BranchPrice, newBranchPrice, Wings.Validators.branchPriceInsert)
#        )


    return isValidSchema.valid
  update: (userId, conversion, fieldNames, modifier)-> true
  remove: (userId, conversion)-> true