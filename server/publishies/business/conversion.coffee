Model.Conversion.allow
  insert: (userId, conversion)->
    cloneSource = {}; cloneSource[key] = value for key, value of conversion
    isValidModel = Wings.IRUS.validate(cloneSource, Wings.Validators.conversionInsert)
    console.log isValidModel

#    if isValidModel.valid
#      product = Model.Product.findOne(conversion.product)
#      unit = Model.Unit.findOne(conversion.unit)
#      return false if !product or !unit
#
#      if product.basicUnit is unit._id
#        Model.BranchProduct.find({product: product._id}).forEach(
#          (branchProduct)->
#            Model.BranchPrice.update({branchProduct: branchProduct._id, isRoot: true}, {$set:{conversion: conversion._id}}, {multi: true})
#        )
#      else
#        Model.BranchProduct.find({product: product._id}).forEach(
#          (branchProduct)->
#            newBranchPrice = {branchProduct: branchProduct._id, conversion: conversion._id, isRoot: false}
#            Wings.IRUS.insert(Model.BranchPrice, newBranchPrice, Wings.Validators.branchPriceInsert)
#        )


    return isValidModel.valid
  update: (userId, conversion, fieldNames, modifier)-> true
  remove: (userId, conversion)-> true