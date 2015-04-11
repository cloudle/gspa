class Wings.Warehouse.Import
  constructor: (doc) -> @[key] = value for key, value of doc

  @insert: (provider = null, description = null, warehouse)->
    newImport             = {warehouse: warehouse}
    newImport.provider    = provider if provider
    newImport.description = description if description
    Wings.IRUS.insert(Model.Import, newImport, Wings.Validators.importInsert)

  insert: ()->
    return {valid: false, error: 'This _id is required!'} if @_id
    newImport             = {warehouse: @warehouse}
    newImport.provider    = @provider if @provider
    newImport.description = @description if @description

    insertResult = Wings.IRUS.insert(Model.Import, newImport, Wings.Validators.importInsert)
    @_id = insertResult.result if insertResult.valid
    return insertResult

  update: (fields)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    result = Wings.Validators.checkExistField(fields, "importUpdateFields")
    if result.valid then updateFields = result.data else return result

    Wings.IRUS.update(Model.Import, @_id, @, updateFields, Wings.Validators.importUpdate)

  remove: ->
    return {valid: false, error: 'This _id is required!'} if !@_id
    Wings.IRUS.remove(Model.Import, @_id)

  insertDetail: (branchPrice, quality = null, price = null, expire = null)->
    return {valid: false, error: 'This _id is required!'} if !@_id
    newImportDetail         = {import: @_id, branchPrice: branchPrice}
    newImportDetail.quality = quality if quality
    newImportDetail.price   = price if price
    newImportDetail.expire  = expire if expire
    Wings.IRUS.insert(Model.ImportDetail, newImportDetail, Wings.Validators.importDetailInsert)

  changProvider: (provider)->
    return {valid: false, error: 'This _id is required!'} if !@_id
    return {valid: false, error: 'This provider is required!'} if !provider
    Wings.IRUS.setField(Model.Import, @, 'provider', provider, Wings.Validators.importUpdate)

  submitImport: ->
    return {valid: false, error: 'This _id is required!'} if !@_id
    return {valid: false, error: 'This Import is Submit!'} if @_id.status is "submit"

    Model.ImportDetail.find({import: @_id}).forEach(
      (importDetail) ->
        quality = importDetail.quality * importDetail.conversionQuality
        updateQuality = {availableQuality: quality, inStockQuality: quality, importQuality: quality}

        Model.BranchProduct.update importDetail.branchProduct, $inc: updateQuality
        Model.Product.update importDetail.product, $inc: updateQuality

        updateQuality.status = "submit"
        Model.ImportDetail.update importDetail._id, $set: updateQuality
    )
    Model.Import.update @_id, $set:{status: "submit"}

