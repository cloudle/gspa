#----BranchProduct----->
Meteor.methods
  updateBranchPrice: (branchPriceId, model, fields)->
    branchPrice = Schema.BranchPrice.findOne(branchPriceId)
    return {valid: false, error: 'branchPriceId is not valid!'} if !branchPrice

    result = Wings.Validators.checkExistField(fields, "branchPriceUpdateFields")
    if result.valid then updateFields = result.data else return result

    updateResult = Wings.IRUS.update(Schema.BranchPrice, branchPriceId, model, updateFields, Wings.Validators.branchPriceUpdate)
    return updateResult