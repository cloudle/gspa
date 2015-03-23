Wings.CRUD.insert = (collection, model, validator, extraChecks) ->
  isValidModel = Wings.CRUD.validate(model, validator)

  return {valid: false, error: isValidModel.error} unless isValidModel.valid
  collection.insert(model)
  return {valid: true}