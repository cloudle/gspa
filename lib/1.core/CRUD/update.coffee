#model param must be the simulatedModel AFTER updated!
Wings.CRUD.updateField = (collection, model, field, validator, extraChecks...) ->
  return {valid: false, error: "Unable to update, #{field} is missing."} if !model[field]

  isValidModel = Wings.CRUD.validate(model, validator)

  return {valid: false, error: isValidModel.error} unless isValidModel.valid
  updateOptions = {}; updateOptions[field] = model[field]
  collection.update(model._id, {$set: updateOptions})
  return {valid: true}