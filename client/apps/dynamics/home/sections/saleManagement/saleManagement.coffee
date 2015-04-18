Wings.defineWidget 'saleManagement',
  sale: -> Session.get("currentSale")
  saleDetails: -> Schema.SaleDetail.find({sale: Session.get("currentSale")?._id})
  staffs: -> Schema.Account.find()
  customers: -> Schema.Customer.find()
  products: -> Schema.BranchProduct.find()
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

  events:
    "click .detail-row": -> Session.set("salesEditingRowId", @_id)

    "change .staffs": (event, template) ->
      staffId = template.find('.staffs').value
      console.log Wings.IRUS.setField(Schema.Sale, Session.get("currentSale"), 'seller', staffId)

    "change .customers": (event, template) ->
      customerId = template.find('.customers').value
      console.log Wings.IRUS.setField(Schema.Sale, Session.get("currentSale"), 'buyer', customerId)

    "change .products": (event, template) ->
      productId = template.find('.products').value
      console.log Wings.IRUS.setField(Schema.Sale, Session.get("currentSale"), 'selectProduct', productId)

    "change .conversions": (event, template) ->
      conversionId = template.find('.conversions').value
      console.log Wings.IRUS.setField(Schema.Sale, Session.get("currentSale"), 'selectConversion', conversionId)

      branchPrice = Schema.BranchPrice.findOne({branchProduct: Session.get("currentSale").selectBranchProduct, conversion: conversionId})
      template.find('.addDetailPrice').value = branchPrice.price; Session.set("currentBranchPrice", branchPrice)

    "change .paymentDelivery": (event, template) ->
      paymentDelivery = Convert.toNumber(template.find('.paymentDelivery').value)
      console.log Wings.IRUS.setField(Schema.Sale, Session.get("currentSale"), 'paymentDelivery', paymentDelivery)

    "change .paymentMethod": (event, template) ->
      paymentMethod = Convert.toNumber(template.find('.paymentMethod').value)
      console.log Wings.IRUS.setField(Schema.Sale, Session.get("currentSale"), 'paymentMethod', paymentMethod)

      if paymentMethod is Wings.Enum.salePaymentMethods.cash
        Meteor.call 'updateSaleDepositCash', Session.get("currentSale")._id, Session.get("currentSale").totalPrice,
          (err, result) -> console.log err, result
      else if paymentMethod is Wings.Enum.salePaymentMethods.debit
        Meteor.call 'updateSaleDepositCash', Session.get("currentSale")._id, 0, (err, result) -> console.log err, result

    "keyup input.saleDeposit": (event, template) ->
      Wings.Helper.deferredAction ->
        sale = Session.get("currentSale"); deposit = template.find('.saleDeposit').value
        if sale and sale.depositCash isnt deposit and deposit >= 0
          Meteor.call 'updateSaleDepositCash', sale._id, deposit, (err, result) -> if result.valid then "" else console.log result.error
      , "updateSaleDepositCash"

    "keyup input.saleDescription": (event, template) ->
      Wings.Helper.deferredAction ->
        sale = Session.get("currentSale"); description = template.find('.saleDescription').value
        if sale and sale.description isnt description
          console.log Wings.IRUS.setField(Schema.Sale, sale, 'description', description)
      , "updateSaleDescription"

    "click .addDetail": (event, template) ->
      saleId        = Session.get("currentSale")?._id
      branchPriceId = Session.get("currentBranchPrice")?._id
      quality       = template.find('.addDetailQuality').value
      price         = template.find('.addDetailPrice').value

      console.log saleId, branchPriceId, quality, price
      Meteor.call 'addSaleDetail', saleId, branchPriceId, quality, price, (err, result) -> console.log err, result

    "click .deleteDetail": (event, template) ->
      Meteor.call 'deleteSaleDetail', @_id, (err, result) -> if result.valid then "" else console.log result.error
      event.stopPropagation()

    "click .saleSubmit": (event, template) ->
      Meteor.call 'submitSale', Session.get("currentSale")._id, (err, result) -> console.log err, result