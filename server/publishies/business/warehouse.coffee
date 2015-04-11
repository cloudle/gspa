Schema.Warehouse.before.insert (userId, warehouse) ->
  warehouse.creator = userId if userId
  warehouse.createdAt = new Date()

Schema.Warehouse.before.update (userId, warehouse, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Schema.Warehouse.allow
  insert: (userId, warehouse)-> true if Schema.Branch.findOne(warehouse.branch)
  update: (userId, warehouse, fieldNames, modifier)-> true
  remove: (userId, warehouse)-> true