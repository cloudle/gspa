Model.Branch.before.insert (userId, warehouse) ->
  warehouse.creator = userId if userId
  warehouse.createdAt = new Date()

Model.Branch.before.update (userId, warehouse, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Model.Branch.after.insert (userId, branch) ->
  Model.Warehouse.insert({name: "Kho chính của chi nhánh #{branch}", branch: branch._id, isRoot: true})

Model.Branch.after.remove (userId, branch) ->
  Model.UserProfile.update({branch: branch._id}, {$set:{branch: branch.root}}, {multi: true})
  #  Model.BranchProduct.remove({branch: branch._id})
  Model.Warehouse.find({branch: branch._id}).forEach(
    (warehouse) ->
      Model.Sale.find({warehouse: warehouse._id}).forEach(
        (sale) ->
          Model.Sale.remove(sale._id)
          Model.SaleDetail.remove({sale: sale._id})
      )
      Model.Import.find({warehouse: warehouse._id}).forEach(
        (currentImport) ->
          Model.Import.remove(currentImport._id)
          Model.ImportDetail.remove({import: currentImport._id})
      )
      Model.Warehouse.remove(warehouse._id)
  )
  Model.PricePolicy.find({branch: branch._id}).forEach(
    (pricePolicy) ->
      Model.PricePolicy.remove(pricePolicy._id)
#      Model.PricePolicyDetail.remove({pricePolicy: pricePolicy._id})
  )


Model.Branch.allow
  insert: (userId, warehouse)-> true
  update: (userId, warehouse, fieldNames, modifier)-> true
  remove: (userId, warehouse)-> true





