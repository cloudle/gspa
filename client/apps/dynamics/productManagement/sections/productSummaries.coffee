scope = logics.home

Wings.defineWidget 'productSummaries',
  managedProducts: -> Schema.Product.find()
  creatorName    : -> Meteor.users.findOne(@creator)?.profile.name if @creator
  isBranchProduct: -> _.contains(@branch ? [], Session.get('mySession')?.branch)
  isDeleteProduct: -> @branch.length is 0

  showFilterSearch: ->
    if search = Session.get("productManagementSearchFilter")
      unsignedName = Wings.Helper.RemoveVnSigns @name
      unsignedName.indexOf(search.unsignedSearch) > -1
    else true

  events:
    "click .editProduct" : ->
      scope.setActiveLayout("productManagement", "productDetail")
      Schema.UserSession.update Session.get("mySession")._id, $set:{currentProduct: @_id}
      Session.set("currentProduct", @)
#      event.stopPropagation()

    "click .addBranchProduct": ->
      branchId = Schema.UserSession.findOne({user: Meteor.userId()}).branch
      Meteor.call('insertBranchProduct', @_id, branchId, (err, result) -> console.log result) if branchId

    "click .deleteBranchProduct" : ->
      branchId = Schema.UserSession.findOne({user: Meteor.userId()}).branch
      branchProduct = Schema.BranchProduct.findOne({product: @_id, branch: branchId}) if branchId
      Meteor.call('removeBranchProduct', branchProduct._id, (err, result) -> console.log result) if branchProduct

    "click .deleteProduct" : ->
      Meteor.call('removeProduct', @_id, (err, result) -> console.log result) if @allowDelete