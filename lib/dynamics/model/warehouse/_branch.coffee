class Model.Branch
  constructor: (doc) -> @[key] = value for key, value of doc

  @insert: (name, address = null, phone = null, description = null)->
    newBranch = {name: name}
    newBranch.address     = address if address
    newBranch.phone       = phone if phone
    newBranch.description = description if description

    Wings.IRUS.insert(Model.Branch, newBranch, Wings.Validators.branchInsert)

  insert: ()->
    return {valid: false, error: 'This record is created'} if @_id
    newBranch = {name: @name}
    newBranch.address     = @address if @address
    newBranch.phone       = @phone if @phone
    newBranch.description = @description if @description

    insertResult = Wings.IRUS.insert(Model.Branch, newBranch, Wings.Validators.branchInsert)
    @_id = insertResult.result if insertResult.valid
    return insertResult

  update: (fields)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    result = Wings.Validators.checkExistField(fields, "branchUpdateFields")
    if result.valid then updateFields = result.data else return result

    Wings.IRUS.update(Model.Branch, @_id, @, updateFields, Wings.Validators.branchUpdate)

  remove: ->
    Wings.IRUS.remove(Model.Branch, @_id)

  createWarehouse: (name, address = null, description = null)->
    newWarehouse = {name: name, branch: @_id}
    newWarehouse.address     = address if address
    newWarehouse.description = description if description

    Wings.IRUS.insert(Model.Warehouse, newWarehouse, Wings.Validators.warehouseCreate)
