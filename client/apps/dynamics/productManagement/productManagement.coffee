scope = logics.home

Wings.defineWidget 'productManagement',
  searchFilter            : -> Session.get("productManagementSearchFilter") ? ""
  isActiveHome            : -> scope.getActiveLayout("productManagement", "home")
  isActiveProductSummaries: -> scope.getActiveLayout("productManagement", "home")
  isActiveProductDetail   : -> scope.getActiveLayout("productManagement", "productDetail")

  events:
    "click li.productHome": -> scope.setActiveLayout("productManagement", "home")
    "input .search-filter": (event, template) ->
      Wings.Helper.DeferredAction ->
        textSearch = template.find("[name=searchFilter]").value
        unsignedSearch = Wings.Helper.RemoveVnSigns(textSearch)
        Session.set("productManagementSearchFilter", {textSearch: textSearch, unsignedSearch: unsignedSearch})
      , "productManagementSearchProduct"