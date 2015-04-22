scope = logics.home

Wings.defineWidget 'productDetail',
  editingBarcode    : -> scope.showConversionEditField(@_id, 'barcode')
  editingImportPrice: -> scope.showConversionEditField(@_id, 'importPrice')
  editingPrice      : -> scope.showConversionEditField(@_id, 'price')

  product: -> Session.get("currentProduct")
  showAddConversion: -> Session.get("currentProduct")?.basicUnit
  conversions: ->
    Schema.Conversion.find({product: product._id}) if product = Session.get("currentProduct")

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
    if currentProduct = Session.get("currentProduct")
      $('.basicUnit').val(currentProduct.basicUnit ? 0)

  events:
    "click .createConversion"  : (event, template) -> scope.conversionCreate(template)
    "click .destroyConversion" : (event, template) -> scope.conversionDestroy(@); event.stopPropagation()
    "change .select-basicUnit" : (event, template) -> scope.productUpdateBasicUnit(template)

    "click td.barcode"    : -> scope.setConversionEditField(@_id, 'barcode')
    "click td.importPrice": -> scope.setConversionEditField(@_id, 'importPrice')
    "click td.price"      : -> scope.setConversionEditField(@_id, 'price')

    "keyup input.editBarcode"     : (event, template) -> scope.conversionUpdateField(event, template, @_id, 'barcode')
    "keyup input.editImportPrice" : (event, template) -> scope.conversionUpdateField(event, template, @_id, 'importPrice')
    "keyup input.editPrice"       : (event, template) -> scope.conversionUpdateField(event, template, @_id, 'price')