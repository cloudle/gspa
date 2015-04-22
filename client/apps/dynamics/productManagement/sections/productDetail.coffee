scope = logics.productManagement

Wings.defineWidget 'productDetail',
  product: -> Session.get("currentProduct")
  showAddConversion: -> Session.get("currentProduct")?.basicUnit
  conversions: -> if product = Session.get("currentProduct") then Schema.Conversion.find({product: product._id})

  editingBarcode: ->
    if branchPrice = Session.get("branchPriceEditingRow")
      branchPrice.conversion is @_id and branchPrice.editing is 'barcode'

  editingImportPrice: ->
    if branchPrice = Session.get("branchPriceEditingRow")
      branchPrice.conversion is @_id and branchPrice.editing is 'importPrice'

  editingPrice: ->
    if branchPrice = Session.get("branchPriceEditingRow")
      branchPrice.conversion is @_id and branchPrice.editing is 'price'

  branchPrice: ->
    if branchProduct = Session.get("currentBranchProduct")
      if branchPrice = Schema.BranchPrice.findOne({branchProduct: branchProduct._id, conversion: @_id})
        branchPrice.importPrice = 0 if !branchPrice.importPrice
        branchPrice.price = 0 if !branchPrice.price
    return branchPrice

  units: ->
    if product = Session.get("currentProduct")
      Schema.Unit.find(if product.basicUnit then {_id: {$ne: product.basicUnit}} else {})

  unitsOfProduct: ->
    if product = Session.get("currentProduct")
      listUnits = product.unit
      if listUnits.length > 0
        (delete listUnits[index] if unit is product.basicUnit) for unit, index in listUnits
        units = Schema.Unit.find({_id: {$nin: listUnits}}).fetch()
      else
        units = Schema.Unit.find().fetch()
        units.push({_id: 0, name: "Chưa Chọn"})
    return units


  rendered: ->
    if Session.get("currentProduct")
      $('.basicUnit').val(Session.get("currentProduct").basicUnit ? 0)

  events:
    "click td.barcode"    : -> scope.setBranchPriceEditingRow(@_id, 'barcode')
    "click td.importPrice": -> scope.setBranchPriceEditingRow(@_id, 'importPrice')
    "click td.price"      : -> scope.setBranchPriceEditingRow(@_id, 'price')

    "keyup input.editBarcode"     : (event, template) -> scope.changeConversion(event, template, @_id, 'barcode')
    "keyup input.editImportPrice" : (event, template) -> scope.changeConversion(event, template, @_id, 'importPrice')
    "keyup input.editPrice"       : (event, template) -> scope.changeConversion(event, template, @_id, 'price')

    "change .basicUnit": (event, template) ->
      model = {basicUnit: template.find('.basicUnit').value}
      Meteor.call 'updateProduct', Session.get("currentProduct")._id, model, 'basicUnit', (err, result) -> console.log result

    "click .addConversion": (event, template)->
      productId  = Session.get("currentProduct")?._id
      unitId     = template.find('.units').value
      conversion = template.find('.conversionQuality').value
      barcode    = template.find('.conversionBarcode').value

      Meteor.call 'insertConversion', productId, unitId, conversion, barcode, (err, result) -> console.log result

    "click .deleteConversion": (event, template)->
      if @allowDelete
        Meteor.call 'removeConversion', @_id, (err, result) -> console.log result
        event.stopPropagation()