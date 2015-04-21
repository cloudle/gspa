Wings.defineWidget 'productManagement',
  price: -> @price ? 0
  importPrice: -> @importPrice ? 0
  products: -> Schema.Product.find()
  branchPrices: -> Schema.BranchPrice.find({branchProduct: Session.get("currentBranchProduct")?._id})

  isActiveProductSummariesLayout: ->
    (activeLayout.layout is "productManagement" and activeLayout.active is "productSummaries") if activeLayout = Session.get("activeLayout")
  isActiveProductDetailLayout: ->
    (activeLayout.layout is "productManagement" and activeLayout.active is "productDetail") if activeLayout = Session.get("activeLayout")


  rendered: ->
    if Session.get("currentProduct")
      $('.search-products').val(Session.get("currentProduct").currentProduct)

  destroyed: ->
    Session.set("currentBranchProduct")

  events:
    "change .search-products": (event, template) ->
      productId = template.find('.search-products').value
      console.log Wings.IRUS.setField(Schema.UserSession, Session.get("mySession"), 'currentProduct', productId)


Wings.defineWidget 'menuProductManagement',
  searchFilter: -> Session.get("productManagementSearchFilter") ? ""
  events:
    "click .productSummaries" : -> Session.set "activeLayout", {layout: "productManagement", active: "productSummaries"}
    "click .productDetail"    : -> Session.set "activeLayout", {layout: "productManagement", active: "productDetail"}
    "input .search-filter": (event, template) ->
      Wings.Helper.DeferredAction ->
        textSearch = template.find("[name=searchFilter]").value
        unsignedSearch = Wings.Helper.RemoveVnSigns(textSearch)
        Session.set("productManagementSearchFilter", {textSearch: textSearch, unsignedSearch: unsignedSearch})
      , "productManagementSearchProduct"