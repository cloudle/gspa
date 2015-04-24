setups.homeInits.push (scope) ->
  scope.showConversionEditField = (conversionId, field) ->
    if branchPrice = Session.get("branchPriceEditingRow")
      branchPrice.conversion is conversionId and branchPrice.editing is field

  scope.setConversionEditField = (conversionId, editing)->
    branchProductId = Session.get("currentBranchProduct")?._id
    branchPrice = Schema.BranchPrice.findOne({branchProduct: branchProductId, conversion: conversionId})
    if _.contains(['barcode', 'importPrice', 'price'], editing)
      branchPrice.editing = editing
      Session.set("branchPriceEditingRow", branchPrice)

  scope.conversionUpdateField = (event, template, conversionId, editing)->
    if branchPrice = Session.get("branchPriceEditingRow")
      if event.which isnt 13
        if branchPrice.conversion is conversionId and branchPrice.editing is editing
          switch editing
            when 'barcode'
              barcode = template.find('.editBarcode').value
              Meteor.call 'updateConversion', branchPrice.conversion, {barcode: barcode}, 'barcode', (err, result) -> console.log result

            when 'importPrice'
              importPrice = Convert.toNumber(template.find('.editImportPrice').value)
              Meteor.call 'updateBranchPrice', branchPrice._id, {importPrice: importPrice}, 'importPrice', (err, result) -> console.log result

            when 'price'
              price = Convert.toNumber(template.find('.editPrice').value)
              Meteor.call 'updateBranchPrice', branchPrice._id, {price: price}, 'price', (err, result) -> console.log result

      else Session.set("branchPriceEditingRow")

  scope.productUpdateBasicUnit = (template)->
    model = {basicUnit: template.find('.select-basicUnit').value}
    Meteor.call 'updateProduct', Session.get("currentProduct")._id, model, 'basicUnit', (err, result) -> console.log result

  scope.conversionCreate = (template)->
    productId  = Session.get("currentProduct")?._id
    unitId     = template.find('.units').value
    conversion = template.find('.conversionQuality').value
    barcode    = template.find('.conversionBarcode').value

    Meteor.call 'insertConversion', productId, unitId, conversion, barcode, (err, result) -> console.log result

  scope.conversionDestroy = (conversionId) ->
    Meteor.call('removeConversion', conversionId, (err, result) -> console.log result) if conversion.allowDelete