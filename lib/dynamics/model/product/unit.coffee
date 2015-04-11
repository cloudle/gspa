class Model.Product.Unit
  constructor: (doc) -> @[key] = value for key, value of doc

  @insert: (name, description = null)->
    newUnit = {name: name}
    newUnit.description = description if description

    Wings.IRUS.insert(Model.Unit, newUnit, Wings.Validators.unitInsert)

  insert: ()->
    return {valid: false, error: 'This record is created'} if @_id

    newUnit = {name: @name}
    newUnit.description = @description if @description

    insertResult = Wings.IRUS.insert(Model.Unit, newUnit, Wings.Validators.unitInsert)
    @_id = insertResult.result if insertResult.valid
    return insertResult

  update: (fields)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    result = Wings.Validators.checkExistField(fields, "unitUpdateFields")
    if result.valid then updateFields = result.data else return result

    Wings.IRUS.update(Model.Unit, @_id, @, updateFields, Wings.Validators.unitUpdate)

  remove: ->
    Wings.IRUS.remove(Model.Unit, @_id)