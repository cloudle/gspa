class Model.Sale.SaleDetail
  constructor: (doc) ->
    @[key] = value for key, value of doc
    if branchPrice = Model.BranchPrice.findOne doc.branchPrice
      @product           = branchPrice.product
      @branch            = branchPrice.branch
      @branchProduct     = branchPrice.branchProduct
      @unit              = branchPrice.unit
      @conversion        = branchPrice.conversion
      @conversionQuality = branchPrice.conversionQuality

  @insert: (saleId, branchPriceId, quality, price)->
    newSaleDetail = {sale: saleId, branchPrice: branchPriceId, quality: quality, price: price}
    Wings.IRUS.insert(Model.SaleDetail, newSaleDetail, Wings.Validators.saleDetailInsert)

  insert: ()->
    return {valid: false, error: 'This record is created'} if @_id

    newSaleDetail = {sale: @sale, branchPrice: @branchPrice, quality: @quality, price: @price}
    insertResult = Wings.IRUS.insert(Model.SaleDetail, newSaleDetail, Wings.Validators.saleDetailInsert)

    @_id = insertResult.result if insertResult.valid
    return insertResult

  update: (fields)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    result = Wings.Validators.checkExistField(fields, "saleDetailUpdateFields")
    if result.valid then updateFields = result.data else return result

    Wings.IRUS.update(Model.SaleDetail, @_id, @, updateFields, Wings.Validators.saleDetailUpdate)

  remove: ->
    Wings.IRUS.remove(Model.SaleDetail, @_id)
