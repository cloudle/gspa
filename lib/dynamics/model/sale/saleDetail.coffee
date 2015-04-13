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
    Meteor.call 'addSaleDetail', saleId, branchPriceId, quality, price, (err, result) ->
      if result.valid then "" else console.log result.error

  insert: ()->
    return {valid: false, error: 'This record is created'} if @_id
    Meteor.call 'addSaleDetail', @sale, @branchPrice, @quality, @price, (err, result) ->
      if result.valid then "" else console.log result.error

  update: (fields)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    result = Wings.Validators.checkExistField(fields, "saleDetailUpdateFields")
    if result.valid then updateFields = result.data else return result

    quality = if _.contains(updateFields, 'quality') then @quality else null
    price   = if _.contains(updateFields, 'price') then @price else null

    Meteor.call 'updateSaleDetail', @_id, quality, price, (err, result) ->

  remove: ->
    Meteor.call 'deleteSaleDetail', @_id, (err, result) ->
      if result.valid then "" else console.log result.error