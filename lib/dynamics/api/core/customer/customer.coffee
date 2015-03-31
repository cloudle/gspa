Wings.Customer = {}

Wings.Customer.insert = (name, phone)->
  newCustomer = {name: name}
  newCustomer.phone = phone if phone

  insertResult = Wings.IRUS.insert(Model.Customer, newCustomer, Wings.Validators.customerCreate)
  console.log insertResult.error unless insertResult.valid
  return insertResult

Wings.Customer.update = (option, customerId = undefined)->
  fields = ['name', 'phone', 'gender', 'description', 'dateOfBirth', 'email', 'address']
  updateResult = Wings.IRUS.update(Model.Customer, customerId, option, fields, Wings.Validators.customerUpdate)
  console.log updateResult.error unless updateResult.valid
  return updateResult

Wings.Customer.remove = (customerId)->
  removeResult = Wings.IRUS.remove(Model.Customer, customerId)
  console.log removeResult.error unless removeResult.valid
  return removeResult