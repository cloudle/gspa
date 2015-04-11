class Model.Warehouse.ImportDetail
  constructor: (doc) ->
    @[key] = value for key, value of doc
    if branchPrice = Schema.BranchPrice.findOne doc.branchPrice
      @product           = branchPrice.product
      @branch            = branchPrice.branch
      @branchProduct     = branchPrice.branchProduct
      @unit              = branchPrice.unit
      @conversion        = branchPrice.conversion
      @conversionQuality = branchPrice.conversionQuality

  @insert: (importId, branchPriceId, quality = null, price = null, expire = null)->
    return {valid: false, error: 'This _id is required!'} if !@_id
    newImportDetail         = {import: importId, branchPrice: branchPriceId}
    newImportDetail.quality = quality if quality
    newImportDetail.price   = price if price
    newImportDetail.expire  = expire if expire
    Wings.IRUS.insert(Schema.ImportDetail, newImportDetail, Wings.Validators.importDetailInsert)

  insert: ()->
    return {valid: false, error: 'This _id is required!'} if @_id
    newImportDetail         = {import: @import, branchPrice: @branchPrice}
    newImportDetail.quality = @quality if @quality
    newImportDetail.price   = @price if @price
    newImportDetail.expire  = @expire if @expire

    insertResult = Wings.IRUS.insert(Schema.ImportDetail, newImportDetail, Wings.Validators.importDetailInsert)
    @_id = insertResult.result if insertResult.valid
    return insertResult

  update: (fields)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    console.log 'update'
    console.log fields
    result = Wings.Validators.checkExistField(fields, "importDetailUpdateFields")
    if result.valid then updateFields = result.data else return result

    Wings.IRUS.update(Schema.ImportDetail, @_id, @, updateFields, Wings.Validators.importDetailUpdate)

  remove: ->
    return {valid: false, error: 'This _id is required!'} if !@_id
    Wings.IRUS.remove(Schema.ImportDetail, @_id)
