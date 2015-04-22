setups.homeInits.push (scope) ->
  scope.saleUpdateFieldBySelect = (field, value)->
    if sale = Session.get("currentSale")
      switch field
        when 'seller'
          model = {seller: value}
        when 'buyer'
          model = {buyer: value}
        when 'selectProduct'
          model = {selectProduct: value}
        when 'selectConversion'
          model = {selectConversion: value}
        when 'paymentDelivery'
          model = {paymentDelivery: Convert.toNumber(value)}
        when 'paymentMethod'
          model = {paymentMethod: Convert.toNumber(value)}

      if model
        Meteor.call 'updateSale', sale._id, model, field, (err, result) -> console.log result

  scope.saleUpdateFieldByInput = (field, value, timeOut = null)->
    if sale = Session.get("currentSale")
      switch field
        when 'quality'
          model = {quality: Convert.toNumberAsb(value)}
        when 'price'
          model = {price: Convert.toNumberAsb(value)}
        when 'depositCash'
          model = {depositCash: Convert.toNumberAsb(value)}
        when 'description'
          model = {description: value}

      Wings.Helper.DeferredAction ->
        if !sale[field] or sale[field] isnt model[field]
          Meteor.call 'updateSale', sale._id, model, field, (err, result) -> console.log result
      , "updateSaleField#{field}"

  scope.saleDetailCreate = ->
    saleId        = Session.get("currentSale")?._id
    branchPriceId = Session.get("currentBranchPrice")?._id
    quality       = Session.get("currentSale")?.quality
    price         = Session.get("currentSale")?.price

    Meteor.call 'insertSaleDetail', saleId, branchPriceId, quality, price, (err, result) -> console.log result