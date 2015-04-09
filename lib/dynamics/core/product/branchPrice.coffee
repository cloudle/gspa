class Wings.Product.BranchPrice
  constructor: (doc) -> @[key] = value for key, value of doc

  @insert: (name, description = null)->
    newProduct = {name: name}
    newProduct.description = description if description
    Wings.IRUS.insert(Model.Product, newProduct, Wings.Validators.productInsert)

  insert: ()->
    return {valid: false, error: 'This record is created'} if @_id
    newProduct = product
    newProduct.name = @name if @name
    newProduct.description = @description if @description
    newProduct.creator     = Meteor.userId() if Meteor.userId()

    insertResult = Wings.IRUS.insert(Model.Product, newProduct, Wings.Validators.productInsert)
    @_id = insertResult.result if insertResult.valid
    return insertResult

  update: (fields)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    result = Wings.Validators.checkExistField(fields, "productUpdateFields")
    if result.valid then updateFields = result.data else return result

    Wings.IRUS.update(Model.Product, @_id, @, updateFields, Wings.Validators.productUpdate)

  remove: ->
    Wings.IRUS.remove(Model.Product, @_id)

product =
  createdAt           : new Date()
  productGroup        : []
  conversion          : []
  availableQuality    : 0
  inOderQuality       : 0
  inStockQuality      : 0
  saleQuality         : 0
  returnSaleQuality   : 0
  importQuality       : 0
  returnImportQuality : 0