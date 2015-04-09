class Wings.Customer.Group
  constructor: (doc) -> @[key] = value for key, value of doc

  @insert: (name, description = null)->
    newCustomer = {name: name}
    newCustomer.description = description if description

    Wings.IRUS.insert(Model.CustomerGroup, newCustomer, Wings.Validators.customerGroupInsert)

  insert: ()->
    return {valid: false, error: 'This record is created'} if @_id
    newCustomer = {name: @name}
    newCustomer.description = @description if @description

    insertResult = Wings.IRUS.insert(Model.CustomerGroup, newCustomer, Wings.Validators.customerGroupInsert)
    @_id = insertResult.result if insertResult.valid
    return insertResult

  update: (fields)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    result = Wings.Validators.checkExistField(fields, "customerGroupUpdateFields")
    if result.valid then updateFields = result.data else return result

    Wings.IRUS.update(Model.CustomerGroup, @_id, @, updateFields, Wings.Validators.customerGroupUpdate)

  remove: ->
    Wings.IRUS.remove(Model.CustomerGroup, @_id)

  addCustomer: (customerId)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    result = Wings.Validators.checkExistField(fields, "customerGroupUpdateFields")
    if result.valid then updateFields = result.data else return result

    Wings.IRUS.update(Model.CustomerGroup, @_id, @, updateFields, Wings.Validators.customerGroupUpdate)