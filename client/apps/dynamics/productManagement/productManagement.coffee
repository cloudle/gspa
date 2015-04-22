scope = logics.home

Wings.defineWidget 'productManagement',
  searchFilter            : -> Session.get("productManagementSearchFilter") ? ""
  isActiveProductSummaries: -> scope.getActiveLayout("productManagement", "home")
  isActiveProductDetail   : -> scope.getActiveLayout("productManagement", "productDetail")

  events:
    "click .productManagement .home"          : -> scope.setActiveLayout("productManagement", "home")
    "click .productManagement .productDetail" : -> scope.setActiveLayout("productManagement", "productDetail")
    "input .search-filter": (event, template) ->
      Wings.Helper.DeferredAction ->
        textSearch = template.find("[name=searchFilter]").value
        unsignedSearch = Wings.Helper.RemoveVnSigns(textSearch)
        Session.set("productManagementSearchFilter", {textSearch: textSearch, unsignedSearch: unsignedSearch})
      , "productManagementSearchProduct"