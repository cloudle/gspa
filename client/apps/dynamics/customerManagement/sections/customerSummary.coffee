scope = logics.home
Wings.defineWidget 'customerDetail',
  customerHistorySales: -> Schema.Sale.find({buyer: @_id, status: "submit"})
  currentCollection: -> Schema.Customer
  finalDebtBalance: ->
     finalDebt =  @debtCash + @loadCash - @paidCash
     if isNaN(finalDebt) then 0 else finalDebt

  events:
    "keyup input.customerName"        : (event, template) -> scope.customerUpdateFieldByInput(event, @_id, 'name', template.find('.customerName').value)
    "keyup input.customerPhone"       : (event, template) -> scope.customerUpdateFieldByInput(event, @_id, 'name', template.find('.customerPhone').value)
    "keyup input.customerAddress"     : (event, template) -> scope.customerUpdateFieldByInput(event, @_id, 'name', template.find('.customerAddress').value)
    "keyup input.customerEmail"       : (event, template) -> scope.customerUpdateFieldByInput(event, @_id, 'name', template.find('.customerEmail').value)
    "keyup input.customerDescription" : (event, template) -> scope.customerUpdateFieldByInput(event, @_id, 'name', template.find('.customerDescription').value)
