scope = logics.home
Wings.defineWidget 'customerDetail',
  historySales: -> Schema.Sale.find({buyer: @_id, status: "submit"})