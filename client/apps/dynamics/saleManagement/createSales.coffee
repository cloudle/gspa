scope = logics.home

Wings.defineWidget 'createSale',
  sale: -> Session.get("currentSale")
  saleDetails: -> Schema.SaleDetail.find({sale: Session.get("currentSale")?._id})
  staffs: -> Schema.Account.find()
  customers: -> Schema.Customer.find()
  branchProducts: -> Schema.BranchProduct.find()
  conversions: -> Schema.Conversion.find({product: Session.get("currentBranchProduct")?.product})
  editingMode: -> Session.get("salesEditingRow")?._id is @_id

  rendered: ->
    if Session.get("currentSale")
      $('.staffs').val(Session.get("currentSale").seller)
      $('.customers').val(Session.get("currentSale").buyer)
      $('.products').val(Session.get("currentSale").selectProduct)
      $('.conversions').val(Session.get("currentSale").selectConversion)
      $('.paymentMethod').val(Session.get("currentSale").paymentMethod)
      $('.paymentDelivery').val(Session.get("currentSale").paymentDelivery)

  events:
    "click .detail-row"  : -> Session.set("salesEditingRowId", @_id)
    "click .addDetail"   : -> scope.saleDetailCreate()
    "click .deleteDetail": (event, template) -> Meteor.call('removeSaleDetail', @_id, (err, result) -> console.log result); event.stopPropagation()
    "click .saleSubmit"  : (event, template) -> Meteor.call('submitSale', Session.get("currentSale")?._id, (err, result) -> console.log result)

    "change .staffs"         : (event, template) -> scope.saleUpdateFieldBySelect('seller'          , template.find('.staffs').value)
    "change .customers"      : (event, template) -> scope.saleUpdateFieldBySelect('buyer'           , template.find('.customers').value)
    "change .branchProducts" : (event, template) -> scope.saleUpdateFieldBySelect('selectProduct'   , template.find('.products').value)
    "change .conversions"    : (event, template) -> scope.saleUpdateFieldBySelect('selectConversion', template.find('.conversions').value)
    "change .paymentDelivery": (event, template) -> scope.saleUpdateFieldBySelect('paymentDelivery' , template.find('.paymentDelivery').value)
    "change .paymentMethod"  : (event, template) -> scope.saleUpdateFieldBySelect('paymentMethod'   , template.find('.paymentMethod').value)

    "keyup input.saleDetailQuality": (event, template) -> scope.saleUpdateFieldByInput('quality'     , template.find('.saleDetailQuality').value)
    "keyup input.saleDetailPrice"  : (event, template) -> scope.saleUpdateFieldByInput('price'       , template.find('.saleDetailPrice').value)
    "keyup input.saleDeposit"      : (event, template) -> scope.saleUpdateFieldByInput('depositCash' , template.find('.saleDeposit').value)
    "keyup input.saleDescription"  : (event, template) -> scope.saleUpdateFieldByInput('description' , template.find('.saleDescription').value)