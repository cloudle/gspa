Schema.Branch.before.insert (userId, warehouse) ->
  warehouse.creator = userId if userId
  warehouse.createdAt = new Date()

Schema.Branch.before.update (userId, warehouse, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Schema.Branch.after.insert (userId, branch) ->
  Schema.Warehouse.insert({name: "Kho chính của chi nhánh #{branch}", branch: branch._id, isRoot: true})

Schema.Branch.after.remove (userId, branch) ->
  Schema.UserProfile.update({branch: branch._id}, {$set:{branch: branch.root}}, {multi: true})
  #  Schema.BranchProduct.remove({branch: branch._id})
  Schema.Warehouse.find({branch: branch._id}).forEach(
    (warehouse) ->
      Schema.Sale.find({warehouse: warehouse._id}).forEach(
        (sale) ->
          Schema.Sale.remove(sale._id)
          Schema.SaleDetail.remove({sale: sale._id})
      )
      Schema.Import.find({warehouse: warehouse._id}).forEach(
        (currentImport) ->
          Schema.Import.remove(currentImport._id)
          Schema.ImportDetail.remove({import: currentImport._id})
      )
      Schema.Warehouse.remove(warehouse._id)
  )
  Schema.PricePolicy.find({branch: branch._id}).forEach(
    (pricePolicy) ->
      Schema.PricePolicy.remove(pricePolicy._id)
#      Schema.PricePolicyDetail.remove({pricePolicy: pricePolicy._id})
  )


Schema.Branch.allow
  insert: (userId, warehouse)-> true
  update: (userId, warehouse, fieldNames, modifier)-> true
  remove: (userId, warehouse)-> true





