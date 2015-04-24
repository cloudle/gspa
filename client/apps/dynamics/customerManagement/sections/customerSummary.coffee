scope = logics.home
Wings.defineWidget 'customerDetail',
  customerHistorySales: -> Schema.Sale.find({buyer: @_id, status: "submit"})
  currentCollection: -> Schema.Customer
  finalDebtBalance: ->
     finalDebt =  @debtCash + @loadCash - @paidCash
     if isNaN(finalDebt) then 0 else finalDebt

