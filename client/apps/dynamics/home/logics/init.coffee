scope = logics.home = {}
setups.homeInits = []
setups.homeReactives = []

#setups.homeInits.push (scope) ->

setups.homeReactives.push (scope) ->
  if Session.get("activeLayout") is "saleManagement"
    Session.set("currentSale", Schema.Sale.findOne({status: {$ne: "submit"} }))

  else if Session.get("activeLayout") is "importManagement"
    Session.set("currentImport", Schema.Import.findOne({status: {$ne: "submit"} }))

  if sale = Session.get("currentSale")
    if Session.get("salesEditingRowId") then Session.set("salesEditingRow", Schema.SaleDetail.findOne(Session.get("salesEditingRowId")))
    else if Session.get("salesEditingRow") then Session.set("salesEditingRow")


    if !(branchProduct = Session.get("currentBranchProduct")) or branchProduct._id isnt sale.selectBranchProduct
      Session.set("currentBranchProduct", Schema.BranchProduct.findOne(sale.selectBranchProduct))

    if sale.selectBranchProduct and sale.selectConversion
      if !(branchPrice = Session.get("currentBranchPrice")) or
        branchPrice.branchProduct isnt sale.selectBranchProduct or branchPrice.conversion isnt sale.selectConversion
          Session.set("currentBranchPrice", Schema.BranchPrice.findOne({branchProduct: sale.selectBranchProduct, conversion: sale.selectConversion}))