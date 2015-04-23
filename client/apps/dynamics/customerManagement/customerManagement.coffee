scope = logics.home
Wings.defineWidget 'customerManagement',
  editingMode : -> Session.get("customerEditing")?._id is @_id
  editingData : -> Session.get("customerEditing")
  isActiveHome: -> scope.getActiveLayout("customerManagement", "home")

  showFilterSearch: -> true
  managedCustomers: -> Schema.Customer.find()


  events:
    "click .showDetail"  : ->
      Session.set("customerEditing", @)
      scope.setActiveLayout("customerManagement", "customerDetail")

    "click li.customerHome"  : ->
      scope.setActiveLayout("customerManagement", "home")