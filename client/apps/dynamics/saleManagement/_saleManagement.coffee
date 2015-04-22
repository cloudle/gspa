scope = logics.home

Wings.defineWidget 'saleManagement',
  isActiveCreateSale  : -> scope.getActiveLayout("saleManagement", "home")
  isActiveHistorySale : -> scope.getActiveLayout("saleManagement", "historySale")

  rendered: ->

  destroyed: ->
    Session.set("salesEditingRow")
    Session.set("salesEditingRowId")
    Session.set("currentBranchProduct")
    Session.set("currentConversion")
    Session.set("currentBranchPrice")

  events:
    "click .saleManagement .home"        : -> scope.setActiveLayout("saleManagement", "home")
    "click .saleManagement .historySale" : -> scope.setActiveLayout("saleManagement", "historySale")