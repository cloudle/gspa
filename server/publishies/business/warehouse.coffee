Model.Warehouse.before.insert (userId, warehouse) ->
  warehouse.creator = userId if userId
  warehouse.createdAt = new Date()

Model.Warehouse.before.update (userId, warehouse, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Model.Warehouse.allow
  insert: (userId, warehouse)-> true if Model.Branch.findOne(warehouse.branch)
  update: (userId, warehouse, fieldNames, modifier)-> true
  remove: (userId, warehouse)-> true