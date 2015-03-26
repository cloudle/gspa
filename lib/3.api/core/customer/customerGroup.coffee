Wings.Customer.Group = {}

Wings.Customer.Group.insert = (name)->
  newGroup = {name: name}

  insertResult = Wings.IRUS.insert(Model.CustomerGroup, newGroup, Wings.Validators.customerGroupCreate)
  console.log insertResult.error unless insertResult.valid
  return insertResult

Wings.Customer.Group.update = (option = {}, groupId = undefined)->
  fields    = ['name', 'description']
  updateResult = Wings.IRUS.update(Model.CustomerGroup, groupId, option, fields, Wings.Validators.customerGroupUpdate)
  console.log updateResult.error unless updateResult.valid
  return updateResult

Wings.Customer.Group.remove = (id)->
  removeResult = Wings.IRUS.remove(Model.CustomerGroup, id)
  console.log removeResult.error unless removeResult.valid
  return removeResult