product       = Session.get("currentProduct")
branchProduct = Session.get("currentBranchProduct")

Wings.defineWidget 'productManagement',
  price: -> @price ? 0
  importPrice: -> @importPrice ? 0
  products: -> Schema.Product.find()
  branchPrices: -> Schema.BranchPrice.find({branchProduct: branchProduct?._id})


  rendered: ->
    if product
      $('.search-products').val(product.currentProduct)

  destroyed: ->
    Session.set("currentBranchProduct")

  events:
    "change .search-products": (event, template) ->
      productId = template.find('.search-products').value
      console.log Wings.IRUS.setField(Schema.UserSession, Session.get("mySession"), 'currentProduct', productId)
