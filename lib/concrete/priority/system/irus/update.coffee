Module 'Wings.IRUS',
  setField: (collection, model, field, value, validator = {}, extraChecks...) ->
    simulate = _(model).clone(); simulate[field] = value
    isValidModel = @validate(simulate, validator)
    return {valid: false, error: isValidModel.error} unless isValidModel.valid
    updateOptions = {}; updateOptions[field] = value
    collection.update(model._id, {$set: updateOptions})
    return {valid: true}

  update: (collection, id, model, fields = [], validator, extraChecks...) ->
    updateOption = @generateObj(model, fields)
    isValidModel = @validate(updateOption, validator)
    return isValidModel unless isValidModel.valid
    model.updateAt = new Date() unless !validator.timestamp?.required and !model.updateAt

    result = collection.update id ? model._id, $set:updateOption if _.keys(updateOption).length > 0
    if result then {valid: true} else {valid: false, error: 'update fail.'}
