setups.homeReactives.push (scope) ->
  if currentSale = Session.get("currentSale")
    if Session.get("salesEditingRowId")
      Session.set("salesEditingRow", Schema.SaleDetail.findOne(Session.get("salesEditingRowId")))
    else if Session.get("salesEditingRow")
      Session.set("salesEditingRow")

    if branchProductId = currentSale.selectBranchProduct
      branchProduct = Session.get("currentBranchProduct")
      Session.set("currentBranchProduct", Schema.BranchProduct.findOne(branchProductId)) if !branchProduct or branchProduct._id isnt branchProductId
    else
      if branchProduct = Schema.BranchProduct.findOne()
        Session.set("currentBranchProduct", branchProduct)
        Wings.IRUS.setField(Schema.Sale, Session.get("currentSale"), 'selectBranchProduct', branchProduct._id)

    if conversionId = currentSale.selectConversion
      conversion = Session.get("currentConversion")
      Session.set("currentConversion", Schema.Conversion.findOne(conversionId)) if !conversion or conversion._id isnt conversionId
    else
      if conversion = Schema.Conversion.findOne({product: branchProduct.product})
        Session.set("currentConversion", branchProduct)
        Wings.IRUS.setField(Schema.Sale, Session.get("currentSale"), 'selectConversion', conversion._id)

    if branchProduct and conversion
      if !(branchPrice = Session.get("currentBranchPrice")) or
        branchPrice.branchProduct isnt branchProduct._id or branchPrice.conversion isnt conversion._id

          branchPrice = Schema.BranchPrice.findOne({branchProduct: branchProduct._id, conversion: conversion._id})
          Session.set("currentBranchPrice", branchPrice)
