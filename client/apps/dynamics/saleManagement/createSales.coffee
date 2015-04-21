Wings.defineWidget 'createSales',
  sale: -> Session.get("currentSale")
  saleDetails: -> Schema.SaleDetail.find({sale: Session.get("currentSale")?._id})
  staffs: -> Schema.Account.find()
  customers: -> Schema.Customer.find()
  branchProducts: -> Schema.BranchProduct.find()
  conversions: -> Schema.Conversion.find({product: Session.get("currentBranchProduct")?.product})

  editingMode: -> Session.get("salesEditingRow")?._id is @_id
  editingData: -> Session.get("salesEditingRow")


  rendered: ->
    if Session.get("currentSale")
      $('.staffs').val(Session.get("currentSale").seller)
      $('.customers').val(Session.get("currentSale").buyer)
      $('.products').val(Session.get("currentSale").selectProduct)
      $('.conversions').val(Session.get("currentSale").selectConversion)
      $('.paymentMethod').val(Session.get("currentSale").paymentMethod)
      $('.paymentDelivery').val(Session.get("currentSale").paymentDelivery)

  destroyed: ->

  events:
    "click .detail-row": -> Session.set("salesEditingRowId", @_id)
    "click .addDetail": (event, template) ->
      saleId        = Session.get("currentSale")?._id
      branchPriceId = Session.get("currentBranchPrice")?._id
      quality       = Session.get("currentSale")?.quality
      price         = Session.get("currentSale")?.price

      Meteor.call 'insertSaleDetail', saleId, branchPriceId, quality, price, (err, result) -> console.log result

    "click .deleteDetail": (event, template) ->
      Meteor.call 'removeSaleDetail', @_id, (err, result) -> console.log result
      event.stopPropagation()

    "click .saleSubmit": (event, template) ->
      Meteor.call 'submitSale', Session.get("currentSale")._id, (err, result) -> console.log result

    "change .staffs": (event, template) ->
      model = {seller: template.find('.staffs').value}
      Meteor.call 'updateSale', Session.get("currentSale")._id, model, 'seller', (err, result) -> console.log result

    "change .customers": (event, template) ->
      model = {buyer: template.find('.customers').value}
      Meteor.call 'updateSale', Session.get("currentSale")._id, model, 'buyer', (err, result) -> console.log result

    "change .branchProducts": (event, template) ->
      model = {selectProduct: template.find('.products').value}
      Meteor.call 'updateSale', Session.get("currentSale")._id, model, 'selectProduct', (err, result) -> console.log result

    "change .conversions": (event, template) ->
      model = {selectConversion: template.find('.conversions').value}
      Meteor.call 'updateSale', Session.get("currentSale")._id, model, 'selectConversion', (err, result) -> console.log result

    "change .paymentDelivery": (event, template) ->
      model = {paymentDelivery: Convert.toNumber(template.find('.paymentDelivery').value)}
      Meteor.call 'updateSale', Session.get("currentSale")._id, model, 'paymentDelivery', (err, result) -> console.log result

    "change .paymentMethod": (event, template) ->
      model = {paymentMethod: Convert.toNumber(template.find('.paymentMethod').value)}
      Meteor.call 'updateSale', Session.get("currentSale")._id, model, 'paymentMethod', (err, result) -> console.log result

    "keyup input.saleDetailQuality": (event, template) ->
      Wings.Helper.DeferredAction ->
        model = {quality: Convert.toNumber(template.find('.saleDetailQuality').value)}; sale = Session.get("currentSale")

        if sale and sale.quality isnt model.quality and model.quality >= 0
          Meteor.call 'updateSale', Session.get("currentSale")._id, model, 'quality', (err, result) -> console.log result

      , "updateSaleDetailQuality"

    "keyup input.saleDetailPrice": (event, template) ->
      Wings.Helper.DeferredAction ->
        model = {price: Convert.toNumber(template.find('.saleDetailPrice').value)}; sale = Session.get("currentSale")

        if sale and sale.price isnt model.price and model.price >= 0
          Meteor.call 'updateSale', Session.get("currentSale")._id, model, 'price', (err, result) -> console.log result

      , "updateSaleDetailPrice"

    "keyup input.saleDeposit": (event, template) ->
      Wings.Helper.DeferredAction ->
        model = {depositCash: Convert.toNumber(template.find('.saleDeposit').value)}; sale = Session.get("currentSale")

        if sale and sale.depositCash isnt model.depositCash and model.depositCash >= 0
          Meteor.call 'updateSale', Session.get("currentSale")._id, model, 'depositCash', (err, result) -> console.log result

      , "updateSaleDepositCash"

    "keyup input.saleDescription": (event, template) ->
      Wings.Helper.DeferredAction ->
        model = {description: template.find('.saleDescription').value}; sale = Session.get("currentSale")

        if sale and sale.description isnt model.description
          Meteor.call 'updateSale', Session.get("currentSale")._id, model, 'description', (err, result) -> console.log result

      , "updateSaleDescription"


