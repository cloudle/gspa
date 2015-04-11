scope = logics.home = {}
setups.homeInits = []
setups.homeReactives = []

#setups.homeInits.push (scope) ->

setups.homeReactives.push (scope) ->
  if Session.get("activeLayout") is "saleLayout"
    Session.set("currentSale", Schema.Sale.findOne({status: {$ne: "submit"} }))

    if selectBranchProduct = Session.get("currentSale")?.selectBranchProduct
      Session.set("currentBranchProduct", Schema.BranchProduct.findOne(selectBranchProduct))

    if Session.get("currentSale")?.selectBranchProduct and Session.get("currentSale")?.selectConversion
      Session.set("currentBranchPrice", Schema.BranchPrice.findOne({
        branchProduct: Session.get("currentSale").selectBranchProduct
        conversion: Session.get("currentSale").selectConversion
      }))



