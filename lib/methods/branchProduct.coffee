#----BranchProduct----->
Meteor.methods
  insertBranchProduct: (productId = null, branchId = null)->
    product = Schema.Product.findOne(productId)
    return {valid: false, error: 'product no found!'} if !product

    branch = Schema.Branch.findOne(branchId)
    return {valid: false, error: 'branch no found!'} if !branch

    return {valid: false, error: 'branchProduct is exist!'} if Schema.BranchProduct.findOne({product: productId, branch: branchId})

    newBranchProduct = Model.Diagrams.BranchProduct()
    newBranchProduct.branch  = branchId
    newBranchProduct.product = productId

    insertResult = Wings.IRUS.insert(Schema.BranchProduct, newBranchProduct, Wings.Validators.branchProductInsert)
    if insertResult.valid
      Schema.Product.update(productId, $addToSet: {branch: branchId})
      for item in product.conversion
        newBranchPrice = Model.Diagrams.BranchPrice()
        newBranchPrice.branchProduct = insertResult.result
        newBranchPrice.conversion    = item
        Schema.BranchPrice.insert newBranchPrice

    return insertResult

  removeBranchProduct: (branchProductId)->
    if branchProduct = Schema.BranchProduct.findOne({_id: branchProductId, allowDelete: true})
      result = Wings.IRUS.remove(Schema.BranchProduct, branchProduct._id)

      if result.valid
        Schema.Product.update branchProduct.product, $pull: {branch: branchProduct.branch}
        Schema.BranchPrice.find({branchProduct: branchProductId}).forEach(
          (branchPrice) -> Schema.BranchPrice.remove branchPrice._id
        )

      return result