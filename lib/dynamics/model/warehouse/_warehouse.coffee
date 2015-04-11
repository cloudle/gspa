class Model.Warehouse
  constructor: (doc) -> @[key] = value for key, value of doc

  #params: name, address = null, description = null, (last)branch
  @insert: ()->
    paramLength = arguments.length
    return {valid: false, error: 'This _id is required!'} if paramLength < 2
    newWarehouse =
      name: arguments[0]
      branch: _.last(arguments)
      isRoot: false

    if paramLength > 2
      for length in (paramLength - 2)
        newWarehouse.address = arguments[length+1]
        newWarehouse.description = arguments[length+1] if length is 1

    Wings.IRUS.insert(Schema.Warehouse, newWarehouse, Wings.Validators.warehouseCreate)

  insert: ()->
    return {valid: false, error: 'This _id is required!'} if @_id
    newWarehouse = {name: @name, branch: @branch, isRoot: false}
    newWarehouse.address = @address if @address
    newWarehouse.description = @description if @description

    insertResult = Wings.IRUS.insert(Schema.Warehouse, newWarehouse, Wings.Validators.warehouseCreate)
    @_id = insertResult.result if insertResult.valid
    return insertResult

  update: (fields)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    result = Wings.Validators.checkExistField(fields, "warehouseUpdateFields")
    if result.valid then updateFields = result.data else return result

    Wings.IRUS.update(Schema.Warehouse, @_id, @, updateFields, Wings.Validators.warehouseUpdate)

  remove: -> Wings.IRUS.remove(Schema.Warehouse, @_id)

  insertImport: (description = null, provider = null)->
    newImport             = {warehouse: @_id}
    newImport.provider    = provider if provider
    newImport.description = description if description
    Wings.IRUS.insert(Schema.Import, newImport, Wings.Validators.importInsert)

