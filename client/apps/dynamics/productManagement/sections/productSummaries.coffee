Wings.defineWidget 'productSummaries',
  managedProducts: -> Schema.Product.find()
  creatorName: -> Meteor.users.findOne(@creator).profile.name if @creator
  showFilterSearch: ->
    if search = Session.get("productManagementSearchFilter")
      unsignedName = Wings.Helper.RemoveVnSigns @name
      unsignedName.indexOf(search.unsignedSearch) > -1
    else true