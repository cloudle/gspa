Wings.defineWidget 'importManagement',
  import: -> Session.get("currentImport")
  importDetails: -> Schema.ImportDetail.find({import: Session.get("currentImport")?._id})
  staffs: -> Schema.Account.find()
  customers: -> Schema.Customer.find()
  products: -> Schema.BranchProduct.find()
  conversions: -> Schema.Conversion.find({product: Session.get("currentBranchProduct")?.product})

  editingMode: -> Session.get("importsEditingRow")?._id is @_id
  editingData: -> Session.get("importsEditingRow")


  created: ->

  events:
    "click .detail-row": -> Session.set("importsEditingRowId", @_id)

    "change .staffs": (event, template) ->
      console.log Wings.IRUS.setField(Schema.Sale, Session.get("currentImport"), 'seller', template.find('.staffs').value)

    "change .customers": (event, template) ->
      console.log Wings.IRUS.setField(Schema.Sale, Session.get("currentImport"), 'buyer', template.find('.customers').value)

    "change .products": (event, template) ->
      console.log Wings.IRUS.setField(Schema.Sale, Session.get("currentImport"), 'selectProduct', template.find('.products').value)

    "change .conversions": (event, template) ->
      console.log Wings.IRUS.setField(Schema.Sale, Session.get("currentImport"), 'selectConversion', template.find('.conversions').value)


    "keyup input.importDeposit": (event, template) ->
      Wings.Helper.deferredAction ->
        currentImport = Session.get("currentImport"); deposit = template.find('.importDeposit').value
        if currentImport and currentImport.depositCash isnt deposit and deposit >= 0
          Meteor.call 'updateSaleDepositCash', currentImport._id, deposit, (err, result) -> if result.valid then "" else console.log result.error
      , "updateSaleDepositCash"

    "click .addDetail": (event, template) ->
      importId        = Session.get("currentImport")?._id
      branchPriceId = Session.get("currentBranchPrice")?._id
      quality       = template.find('.addDetailQuality').value
      price         = template.find('.addDetailPrice').value

      Meteor.call 'addSaleDetail', importId, branchPriceId, quality, price, (err, result) ->
        if result.valid then "" else console.log result.error

    "click .deleteDetail": (event, template) ->
      Meteor.call 'deleteSaleDetail', @_id, (err, result) -> if result.valid then "" else console.log result.error
      event.stopPropagation()

    "click .importSubmit": (event, template) ->
      Meteor.call 'submitSale', Session.get("currentImport")._id, (err, result) -> console.log err, result