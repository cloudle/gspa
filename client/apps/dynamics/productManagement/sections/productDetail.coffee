Wings.defineWidget 'productDetail',
  showAddConversion: -> Session.get("currentProduct")?.basicUnit
  product : -> Session.get("currentProduct")
  conversions : -> if product = Session.get("currentProduct") then Schema.Conversion.find({product: product._id})
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
    "change .basicUnit": (event, template) ->
      model = {basicUnit: template.find('.basicUnit').value}
      Meteor.call 'updateProduct', Session.get("currentProduct")._id, model, 'basicUnit', (err, result) -> console.log result

    "click .addConversion": (event, template)->
      productId  = Session.get("currentProduct")?._id
      unitId     = template.find('.units').value
      conversion = template.find('.conversionQuality').value
      barcode    = template.find('.barcode').value

      Meteor.call 'insertConversion', productId, unitId, conversion, barcode, (err, result) -> console.log result

    "click .deleteConversion": (event, template)->
      if @allowDelete
        Meteor.call 'removeConversion', @_id, (err, result) -> console.log result
        event.stopPropagation()