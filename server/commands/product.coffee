Meteor.methods
  productSetBasicUnit: (productId, unitId)->
    newConvention = {product: productId, unit: unitId, conversion: 1}
    insertResult = Wings.IRUS.insert(Model.Conversion, newConvention, Wings.Validators.conversionInsert)
    if insertResult.valid
      Model.BranchProduct.find({product: @_id}).forEach(
        (branchProduct)->
          Model.BranchPrice.update
            branchProduct: branchProduct._id, isRoot: true
          ,
            $set:{conversion: insertResult.result}
          ,
            multi: true
      )