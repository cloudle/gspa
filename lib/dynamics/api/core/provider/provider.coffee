class Wings.Provider
  constructor: (doc) -> @[key] = value for key, value of doc

  @insert: (name, phone = null)->
    newProvider = {name: name}
    newProvider.phone = phone if phone
    Wings.IRUS.insert(Model.Provider, newProvider, Wings.Validators.providerInsert)

  insert: ()->
    return {valid: false, error: 'This record is created'} if @_id
    newProvider = {name: @name}
    newProvider.phone = @phone if @phone

    insertResult = Wings.IRUS.insert(Model.Provider, newProvider, Wings.Validators.providerInsert)
    @_id = insertResult.result if insertResult.valid
    return insertResult

  update: (fields)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    result = Wings.Validators.checkExistField(fields, "providerUpdateFields")
    if result.valid then updateFields = result.data else return result

    Wings.IRUS.update(Model.Provider,  @_id, @, updateFields, Wings.Validators.providerUpdate)

  remove: ->
    Wings.IRUS.remove(Model.Branch, @_id)