setups.homeInits.push (scope) ->
  scope.saleUpdateFieldBySelect = (saleId, field, value)->
    if _.contains(Wings.Validators.saleUpdateFields, field)
      model = {}; model[field] = value
      if _.keys(model).length > 0
        Meteor.call('updateSale', saleId, model, field, (err, result) -> console.log result)
    else
      console.log("update fail !")


  scope.saleUpdateFieldByInput = (saleId, field, value, timeOut = null)->
    if _.contains(Wings.Validators.saleUpdateFields, field)
      model = {}; model[field] = value
      if _.keys(model).length > 0
        Wings.Helper.DeferredAction ->
          Meteor.call('updateSale', saleId, model, field, (err, result) -> console.log result)
        , "updateSaleField#{field}"
    else
      console.log("update fail !")

  scope.saleDetailCreate = ->
    saleId        = Session.get("currentSale")?._id
    branchPriceId = Session.get("currentBranchPrice")?._id
    quality       = Session.get("currentSale")?.quality
    price         = Session.get("currentSale")?.price

    Meteor.call 'insertSaleDetail', saleId, branchPriceId, quality, price, (err, result) -> console.log result