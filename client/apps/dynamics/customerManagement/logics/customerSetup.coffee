setups.homeInits.push (scope) ->
  scope.customerUpdateFieldByInput = (event, customerId, field, value) ->
    customer = Session.get("customerEditing")
    return if !customer or customer._id isnt customerId

    (Session.set("branchPriceEditingRow"); return) if event.which is 13
    if _.contains(Wings.Validators.customerUpdateFields, field)
      model = {}; model[field] = value
      if _.keys(model).length > 0
        Wings.Helper.DeferredAction ->
          Meteor.call('updateCustomer', customerId, model, field, (err, result) -> console.log result)
        , "updateCustomerField#{field}"