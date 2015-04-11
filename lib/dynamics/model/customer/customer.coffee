class Model.Customer
  constructor: (doc) -> @[key] = value for key, value of doc

  @insert: (name, address = null, phone = null, description = null)->
    newCustomer = {name: name}
    newCustomer.address     = address if address
    newCustomer.phone       = phone if phone
    newCustomer.description = description if description

    Wings.IRUS.insert(Model.Customer, newCustomer, Wings.Validators.customerInsert)

  insert: ()->
    return {valid: false, error: 'This record is created'} if @_id
    newCustomer = {name: @name}
    newCustomer.phone = @phone if @phone

    insertResult = Wings.IRUS.insert(Model.Customer, newCustomer, Wings.Validators.customerInsert)
    @_id = insertResult.result if insertResult.valid
    return insertResult

  update: (fields)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    result = Wings.Validators.checkExistField(fields, "customerUpdateFields")
    if result.valid then updateFields = result.data else return result

    Wings.IRUS.update(Model.Customer, @_id, @, updateFields, Wings.Validators.customerUpdate)

  remove: ->
    Wings.IRUS.remove(Model.Customer, @_id)

  addCustomerGroup: (customerGroupId)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    result = Wings.Validators.checkExistField(fields, "customerGroupUpdateFields")
    if result.valid then updateFields = result.data else return result

    Wings.IRUS.update(Model.Customer, @_id, @, updateFields, Wings.Validators.customerUpdate)