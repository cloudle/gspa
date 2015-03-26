Wings.IRUS.setField = (collection, model, field, value, validator = {}, extraChecks...) ->
  simulate = _(model).clone(); simulate[field] = value
  isValidModel = Wings.IRUS.validate(simulate, validator)
  return {valid: false, error: isValidModel.error} unless isValidModel.valid
  updateOptions = {}; updateOptions[field] = value
  collection.update(model._id, {$set: updateOptions})
  return {valid: true}

Wings.IRUS.update = (collection, id, model, fields = [], validator, extraChecks...) ->
  updateOption = Wings.IRUS.generateObj(model, fields)
  isValidModel = Wings.IRUS.validate(updateOption, validator)
  return isValidModel unless isValidModel.valid

  result = collection.update id ? model._id, $set:updateOption if _.keys(updateOption).length > 0
  if result then {valid: true} else {valid: false, error: 'update fail.'}
