Wings.defineWidget 'saleManagement',
  isActiveCreateSalesLayout: ->
    (activeLayout.layout is "saleManagement" and activeLayout.active is "createSales") if activeLayout = Session.get("activeLayout")
  isActiveHistorySalesLayout: ->
    (activeLayout.layout is "saleManagement" and activeLayout.active is "historySales") if activeLayout = Session.get("activeLayout")

  rendered: ->

  destroyed: ->
    Session.set("salesEditingRow")
    Session.set("salesEditingRowId")
    Session.set("currentBranchProduct")
    Session.set("currentConversion")
    Session.set("currentBranchPrice")

  events:
    "click .createSales"  : -> Session.set "activeLayout", {layout: "saleManagement", active: "createSales"}
    "click .historySales" : -> Session.set "activeLayout", {layout: "saleManagement", active: "historySales"}