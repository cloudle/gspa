setups.homeReactives.push (scope) ->
  if currentProduct = Session.get("currentProduct")
    branchProduct = Schema.BranchProduct.findOne({product: currentProduct._id, branch: Session.get("mySession")?.branch})
    Session.set("currentBranchProduct", branchProduct)