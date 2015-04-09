class Wings.Product.BranchProduct
  constructor: (doc) -> @[key] = value for key, value of doc

  @insert: (branchId, productId)->
    newBranchProduct = {branch: branchId, product: productId}
    Wings.IRUS.insert(Model.BranchProduct, newBranchProduct, Wings.Validators.branchProductInsert)

  insert: ()->
    return {valid: false, error: 'This record is created'} if @_id

    newBranchProduct = {branch: @branch, product: @product}
    insertResult = Wings.IRUS.insert(Model.BranchProduct, newBranchProduct, Wings.Validators.branchProductInsert)

    @_id = insertResult.result if insertResult.valid
    return insertResult

  update: (fields)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    result = Wings.Validators.checkExistField(fields, "productUpdateFields")
    if result.valid then updateFields = result.data else return result

    Wings.IRUS.update(Model.BranchProduct, @_id, @, updateFields, Wings.Validators.productUpdate)

  remove: ->
    Wings.IRUS.remove(Model.BranchProduct, @_id)