Wings.CRUD.setField = (collection, model, field, value, validator = {}, extraChecks...) ->
  simulate = _(model).clone(); simulate[field] = value
  isValidModel = Wings.CRUD.validate(simulate, validator)
  return {valid: false, error: isValidModel.error} unless isValidModel.valid
  updateOptions = {}; updateOptions[field] = value
  collection.update(model._id, {$set: updateOptions})
  return {valid: true}