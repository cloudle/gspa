#----BranchProduct----->
Meteor.methods
  updateBranchPrice: (branchPriceId, model, fields)->
    if Schema.BranchPrice.findOne(branchPriceId)
      result = Wings.Validators.checkExistField(fields, "branchPriceUpdateFields")
      if result.valid then updateFields = result.data else return result

      updateResult = Wings.IRUS.update(Schema.BranchPrice, branchPriceId, model, updateFields, Wings.Validators.branchPriceUpdate)
      return updateResult