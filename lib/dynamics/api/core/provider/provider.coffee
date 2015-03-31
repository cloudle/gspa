Wings.Provider = {}

Wings.Provider.insert = (name, phone = undefined)->
  newProvider = {name: name}
  newProvider.phone = phone if phone

  insertResult = Wings.IRUS.insert(Model.Provider, newProvider, Wings.Validators.providerCreate)
  console.log insertResult.error unless insertResult.valid
  return insertResult


Wings.Provider.update = (option, providerId = undefined)->
  fields = ['name', 'phone', 'description', 'address']
  updateResult = Wings.IRUS.update(Model.Provider, providerId, option, fields, Wings.Validators.providerUpdate)
  console.log updateResult.error unless updateResult.valid
  return updateResult

Wings.Provider.remove = (providerId)->
  removeResult = Wings.IRUS.remove(Model.Provider, providerId)
  console.log removeResult.error unless removeResult.valid
  return removeResult

