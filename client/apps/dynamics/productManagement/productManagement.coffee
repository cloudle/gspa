Wings.defineWidget 'productManagement',
  searchFilter: -> Session.get("productManagementSearchFilter") ? ""
  isActiveProductSummariesLayout: ->
    if activeLayout = Session.get("activeLayout")
      activeLayout.layout is "productManagement" and activeLayout.active is "productSummaries"

  isActiveProductDetailLayout: ->
    if activeLayout = Session.get("activeLayout")
      activeLayout.layout is "productManagement" and activeLayout.active is "productDetail"

  events:
    "click .productSummaryLayout" : -> Session.set "activeLayout", {layout: "productManagement", active: "productSummaries"}
    "click .productDetailLayout"  : -> Session.set "activeLayout", {layout: "productManagement", active: "productDetail"}
    "input .search-filter": (event, template) ->
      Wings.Helper.DeferredAction ->
        textSearch = template.find("[name=searchFilter]").value
        unsignedSearch = Wings.Helper.RemoveVnSigns(textSearch)
        Session.set("productManagementSearchFilter", {textSearch: textSearch, unsignedSearch: unsignedSearch})
      , "productManagementSearchProduct"