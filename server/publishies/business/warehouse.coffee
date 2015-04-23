Schema.Warehouse.allow
  insert: (userId, warehouse)-> true if Schema.Branch.findOne(warehouse.branch)
  update: (userId, warehouse, fieldNames, modifier)-> true
  remove: (userId, warehouse)-> true