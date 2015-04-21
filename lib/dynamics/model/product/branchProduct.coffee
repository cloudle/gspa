class Model.Product.BranchProduct
  constructor: (doc) ->
    @[key] = value for key, value of doc
    if product = Schema.Product.findOne doc.product
      @productName = product.name

  @insert: (productId, branchId)->
    Meteor.call 'insertBranchProduct', productId, branchId, (err, result) ->console.log result

  insert: ()->
    self = @
    return {valid: false, error: 'This record is created'} if @_id
    Meteor.call 'insertBranchProduct', @product, @branch,
      (err, result) -> if result.valid then self._id = result.result; console.log result

  remove: ->
    Meteor.call 'removeBranchProduct', @_id, (err, result) ->console.log result