setups.homeReactives.push (scope) ->
  if currentProduct = Session.get("currentProduct")
    branchProduct = Schema.BranchProduct.findOne({product: currentProduct._id, branch: Session.get("mySession")?.branch})
    Session.set("currentBranchProduct", branchProduct)

Module 'logics.productManagement',
  setBranchPriceEditingRow: (conversionId, editing)->
    branchProductId = Session.get("currentBranchProduct")?._id
    branchPrice = Schema.BranchPrice.findOne({branchProduct: branchProductId, conversion: conversionId})
    if _.contains(['barcode', 'importPrice', 'price'], editing)
      branchPrice.editing = editing
      Session.set("branchPriceEditingRow", branchPrice)

  changeConversion: (event, template, conversionId, editing)->
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
