scope = logics.home = {}
setups.homeInits = []
setups.homeReactives = []

#setups.homeInits.push (scope) ->

setups.homeReactives.push (scope) ->
  Session.set("mySession", Schema.UserSession.findOne {user: Meteor.userId()} ) if Meteor.userId()

  if activeLayout = Session.get("activeLayout")
    if activeLayout.layout is "saleManagement"
      foundSale = Schema.Sale.findOne({status: {$ne: "submit"}})
    else if activeLayout.layout is "importManagement"
      foundImport = Schema.Import.findOne({status:{$ne: "submit"}})
    else if activeLayout.layout is "productManagement"
      foundProduct = Schema.Product.findOne(Session.get("mySession").currentProduct)

    Session.set("currentSale", foundSale)
    Session.set("currentImport", foundImport)
    Session.set("currentProduct", foundProduct)