class Model.Product.BranchProduct
  constructor: (doc) ->
    @[key] = value for key, value of doc
    if product = Schema.Product.findOne doc.product
      @productName = product.name

  @insert: (branchId, productId)->
    newBranchProduct = {branch: branchId, product: productId}
    Wings.IRUS.insert(Schema.BranchProduct, newBranchProduct, Wings.Validators.branchProductInsert)

  insert: ()->
    return {valid: false, error: 'This record is created'} if @_id

    newBranchProduct = {branch: @branch, product: @product}
    insertResult = Wings.IRUS.insert(Schema.BranchProduct, newBranchProduct, Wings.Validators.branchProductInsert)

    @_id = insertResult.result if insertResult.valid
    return insertResult

  update: (fields)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    result = Wings.Validators.checkExistField(fields, "productUpdateFields")
    if result.valid then updateFields = result.data else return result

    Wings.IRUS.update(Schema.BranchProduct, @_id, @, updateFields, Wings.Validators.productUpdate)

  remove: ->
    Wings.IRUS.remove(Schema.BranchProduct, @_id)