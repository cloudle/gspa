Wings.defineWidget 'sidebar',
  activeImportLayout: -> Session.get("activeLayout") is "importLayout"
  activeSaleLayout: -> Session.get("activeLayout") is "saleLayout"
  activeProductLayout: -> Session.get("activeLayout") is "productLayout"

  events:
    "click .selectImport": (event, template) -> Session.set("activeLayout", "importLayout")
    "click .selectSale": (event, template) -> Session.set("activeLayout", "saleLayout")
    "click .selectProduct": (event, template) -> Session.set("activeLayout", "productLayout")


Wings.defineWidget 'layoutSale',
  sale: -> Session.get("currentSale")
  saleDetails: -> Schema.SaleDetail.find({sale: Session.get("currentSale")?._id})
  staffs: -> Schema.Account.find()
  customers: -> Schema.Customer.find()
  products: -> Schema.BranchProduct.find()
  conversions: -> Schema.Conversion.find({product: Session.get("currentBranchProduct")?.product})

  created: ->

  events:
    "change .staffs": (event, template) ->
      console.log Wings.IRUS.setField(Schema.Sale, Session.get("currentSale"), 'seller', template.find('.staffs').value)

    "change .customers": (event, template) ->
      console.log Wings.IRUS.setField(Schema.Sale, Session.get("currentSale"), 'buyer', template.find('.customers').value)

    "change .products": (event, template) ->
      console.log Wings.IRUS.setField(Schema.Sale, Session.get("currentSale"), 'selectProduct', template.find('.products').value)

    "change .conversions": (event, template) ->
      console.log Wings.IRUS.setField(Schema.Sale, Session.get("currentSale"), 'selectConversion', template.find('.conversions').value)

    "click .saleAddDetail": (event, template) ->
      branchPriceId = Session.get("currentBranchPrice")?._id
      quality = template.find('.addDetailQuality').value
      price   = template.find('.addDetailPrice').value
      if sale = Schema.Sale.findOne(Session.get("currentSale")._id)
        console.log sale.insertDetail(branchPriceId, quality, price)


    "click .saleSubmit": (event, template) ->
      sale = Schema.Sale.findOne(Session.get("currentSale")._id)
