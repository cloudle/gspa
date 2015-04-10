class Wings.Product.ProductGroup
  constructor: (doc) -> @[key] = value for key, value of doc

  @insert: (name, warehouse = null)->
    newGroup = {name: name}
    newGroup.warehouse = warehouse if warehouse
    newGroup.creator   = Meteor.userId() if Meteor.userId()

    Wings.IRUS.insert(Model.ProductGroup, newGroup, Wings.Validators.productGroupInsert)

  insert: ()->
    return {valid: false, error: 'This record is created'} if @_id
    newGroup = {name: @name}
    newGroup.warehouse = @warehouse
    newGroup.creator   = Meteor.userId() if Meteor.userId()

    insertResult = Wings.IRUS.insert(Model.ProductGroup, newGroup, Wings.Validators.productGroupInsert)
    @_id = insertResult.result if insertResult.valid
    return insertResult

  update: (fields)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    result = Wings.Validators.checkExistField(fields, "productGroupUpdateFields")
    if result.valid then updateFields = result.data else return result

    Wings.IRUS.update(Model.ProductGroup, @_id, @, updateFields, Wings.Validators.productGroupUpdate)

  remove: ->
    Wings.IRUS.remove(Model.ProductGroup, @_id)

  addProduct: (productLists)->
    if _.isArray(productLists) then arrayProduct = productLists else arrayProduct = [productLists]

    if Match.test(arrayProduct, [String])
      return {valid: false, error: "productLists is required."} if arrayProduct.length < 1
    else
      return {valid: false, error: "productLists is required."}

    if (Model.ProductGroup.update @_id, $addToSet: {productList: {$each: arrayProduct}})
      (Model.Product.update productId, $addToSet: {productGroup: @_id}) for productId in arrayProduct
      return {valid: true}
    else
      return {valid: false, error: 'productGroupId is not valid.'}

  removeProduct: (productLists = undefined)->
    if _.isArray(productLists) then arrayProduct = productLists else arrayProduct = [productLists]

    if Match.test(arrayProduct, [String])
      return {valid: false, error: "productLists is required."} if arrayProduct.length < 1
    else
      return {valid: false, error: "productLists is required."}

    for productId in arrayProduct
      if (Model.ProductGroup.update @_id, $pull: {productList: productId})
        Model.Product.update productId, $pull: {productGroup: @_id}
      else
        return {valid: false, error: "productGroupId is not valid."}
    return {valid: true}