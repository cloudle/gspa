Module 'Wings.IRUS',
  insert: (collection, model, validator = {}, extraChecks) ->
    isValidModel = Wings.IRUS.validate(model, validator)
    if !validator.timestamp?.required and !model.createAt
      model.createAt = new Date()
      model.updateAt = new Date()

    return {valid: false, error: isValidModel.error} unless isValidModel.valid
    resultId = collection.insert(model)
    if resultId then {valid: true, result: resultId} else {valid: false, error: 'insert fail.'}