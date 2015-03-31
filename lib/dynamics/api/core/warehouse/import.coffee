Wings.Warehouse.Import = {}

Wings.Warehouse.Import.insert = (provider, description, warehouse = null)->
  newImport = {}
  newImport.description = description if description
  newImport.provider    = provider if provider
  newImport.warehouse   = warehouse if warehouse

  insertResult = Wings.IRUS.insert(Model.Import, newImport, Wings.Validators.productGroupCreate)
  console.log insertResult.error unless insertResult.valid
  return insertResult

Wings.Warehouse.Import.update = (importId)->
Wings.Warehouse.Import.remove = (importId)->