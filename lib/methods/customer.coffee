#----Customer----->
Meteor.methods
  insertCustomer: (name = null, phone = null, gender = null, description = null)->
    return {valid: false, error: 'name is empty!'} if !name
    return {valid: false, error: 'name is exist!'} if Schema.Customer.findOne({name: name})
    return {valid: false, error: 'phone is exist!'} if phone and Schema.Customer.findOne({phone: phone})
    return {valid: false, error: 'Branch not found!'} if !(branchId = Schema.UserSession.findOne({user: @userId}).branch)

    newCustomer = Model.Diagrams.Customer
    newCustomer.name        = name
    newCustomer.branch      = branchId
    newCustomer.phone       = phone if phone
    newCustomer.gender      = gender if gender isnt null
    newCustomer.description = description if description

    insertResult = Wings.IRUS.insert(Schema.Customer, newCustomer, Wings.Validators.customerInsert)
    return insertResult

  updateCustomer: (customerId, model, fields)->
    customer = Schema.Customer.findOne(customerId)
    return {valid: false, error: 'customerId is not valid!'} if !customer

    result = Wings.Validators.checkExistField(fields, "customerUpdateFields")
    if result.valid then updateFields = result.data else return result

    if _.contains(updateFields, 'name')
      return {valid: false, error: 'name is exist!'} if Schema.Customer.findOne({name: model.name})

    if _.contains(updateFields, 'phone')
      return {valid: false, error: 'phone is exist!'} if Schema.Customer.findOne({phone: model.phone})

    updateResult = Wings.IRUS.update(Schema.Customer, customer._id, model, updateFields, Wings.Validators.customerUpdate)
    return updateResult

  removeCustomer: (customerId)->
    Schema.Customer.findOne({_id: customerId, allowDelete: true})
    return {valid: false, error: 'customerId is not valid!'} if !customer

    result = Wings.IRUS.remove(Schema.Customer, customerId)
    return result