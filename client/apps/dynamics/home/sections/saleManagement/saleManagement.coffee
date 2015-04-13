Wings.defineWidget 'saleManagement',
  sale: -> Session.get("currentSale")
  saleDetails: -> Schema.SaleDetail.find({sale: Session.get("currentSale")?._id})
  staffs: -> Schema.Account.find()
  customers: -> Schema.Customer.find()
  products: -> Schema.BranchProduct.find()
  conversions: -> Schema.Conversion.find({product: Session.get("currentBranchProduct")?.product})

  editingMode: -> Session.get("salesEditingRow")?._id is @_id
  editingData: -> Session.get("salesEditingRow")


  created: ->

  events:
    "click .detail-row": -> Session.set("salesEditingRowId", @_id)

    "change .staffs": (event, template) ->
      console.log Wings.IRUS.setField(Schema.Sale, Session.get("currentSale"), 'seller', template.find('.staffs').value)

    "change .customers": (event, template) ->
      console.log Wings.IRUS.setField(Schema.Sale, Session.get("currentSale"), 'buyer', template.find('.customers').value)

    "change .products": (event, template) ->
      console.log Wings.IRUS.setField(Schema.Sale, Session.get("currentSale"), 'selectProduct', template.find('.products').value)

    "change .conversions": (event, template) ->
      console.log Wings.IRUS.setField(Schema.Sale, Session.get("currentSale"), 'selectConversion', template.find('.conversions').value)


    "keyup input.saleDeposit": (event, template) ->
      Wings.Helper.deferredAction ->
        sale = Session.get("currentSale"); deposit = template.find('.saleDeposit').value
        if sale and sale.depositCash isnt deposit and deposit >= 0
          Meteor.call 'updateSaleDepositCash', sale._id, deposit, (err, result) -> if result.valid then "" else console.log result.error
      , "updateSaleDepositCash"

    "click .addDetail": (event, template) ->
      saleId        = Session.get("currentSale")?._id
      branchPriceId = Session.get("currentBranchPrice")?._id
      quality       = template.find('.addDetailQuality').value
      price         = template.find('.addDetailPrice').value

      Meteor.call 'addSaleDetail', saleId, branchPriceId, quality, price, (err, result) ->
        if result.valid then "" else console.log result.error

    "click .deleteDetail": (event, template) ->
      Meteor.call 'deleteSaleDetail', @_id, (err, result) -> if result.valid then "" else console.log result.error
      event.stopPropagation()


    "click .saleSubmit": (event, template) ->
      Meteor.call 'submitSale', Session.get("currentSale")._id, (err, result) ->
        if result.valid then "" else console.log result.error