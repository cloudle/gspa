class Model.Sale.SaleDetail
  constructor: (doc) ->
    @[key] = value for key, value of doc
    if branchPrice = Schema.BranchPrice.findOne doc.branchPrice
      @product           = branchPrice.product
      @branch            = branchPrice.branch
      @branchProduct     = branchPrice.branchProduct
      @unit              = branchPrice.unit
      @conversion        = branchPrice.conversion
      @conversionQuality = branchPrice.conversionQuality

      @productName = Schema.Product.findOne(branchPrice.product).name
      @unitName    = Schema.Unit.findOne(branchPrice.unit).name

  @insert: (saleId, branchPriceId, quality, price)->
    Meteor.call 'insertSaleDetail', saleId, branchPriceId, quality, price, (err, result) -> console.log err, result

  insert: ()->
    return {valid: false, error: 'This record is created'} if @_id
    Meteor.call 'insertSaleDetail', @sale, @branchPrice, @quality, @price, (err, result) -> console.log err, result

  update: (fields)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    validator = Wings.Validators.checkExistField(fields, "saleDetailUpdateFields")
    if validator.valid then updateFields = validator.data else return validator

    quality = if _.contains(updateFields, 'quality') then @quality else null
    price   = if _.contains(updateFields, 'price') then @price else null

    Meteor.call 'updateSaleDetail', @_id, quality, price, (err, result) -> console.log err, result

  remove: ->
    return {valid: false, error: 'This _id is required!'} if !@_id
    Meteor.call 'removeSaleDetail', @_id, (err, result) -> console.log err, result