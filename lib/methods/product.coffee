#----Product----->
Meteor.methods
  insertProduct: (name = null, description = null)->
    return {valid: false, error: 'name is empty!'} if !name
    return {valid: false, error: 'name is exist!'} if Schema.Product.findOne({name: name})

    branchId = Schema.UserSession.findOne({user: @userId}).branch

    newProduct = Model.Diagrams.Product
    newProduct.name = name
    newProduct.description = description if description

    insertResult = Wings.IRUS.insert(Schema.Product, newProduct, Wings.Validators.productInsert)
    if insertResult.valid
      Meteor.call 'insertDefaultConversion', insertResult.result, branchId
    return insertResult

  updateProduct: (productId, model, fields)->
    product = Schema.Product.findOne(productId)
    return {valid: false, error: 'productId is not valid!'} if !product

    result = Wings.Validators.checkExistField(fields, "productUpdateFields")
    if result.valid then updateFields = result.data else return result

    if _.contains(updateFields, 'basicUnit')
      if product.basicUnit
        return {valid: false, error: 'basicUnit trùng lắp'} if product.basicUnit is model.basicUnit
        return {valid: false, error: 'không thể sửa đổi basicUnit'} if _.contains(product.unit, model.basicUnit)

    if _.contains(updateFields, 'name')
      return {valid: false, error: 'name is exist!'} if Schema.Product.findOne({name: model.name})

    updateResult = Wings.IRUS.update(Schema.Product, product._id, model, updateFields, Wings.Validators.productUpdate)
    if updateResult.valid
      if _.contains(updateFields, 'basicUnit')
        conversionQuery = {product: product._id}
        conversionQuery.unit = product.basicUnit if product.basicUnit
        conversion = Schema.Conversion.findOne(conversionQuery)
        Schema.Conversion.update conversion._id, $set:{unit: model.basicUnit}
        Schema.Product.update product._id, $pull: {unit: product.basicUnit}, $push: {unit: model.basicUnit}
    return updateResult

  removeProduct: (productId)->
    Schema.Product.findOne({_id: productId, allowDelete: true})
    return {valid: false, error: 'productId is not valid!'} if !product

    result = Wings.IRUS.remove(Schema.Product, productId)
    if result.valid
      conversions    = Schema.Conversion.find({product: productId}).fetch()
      branchProducts = Schema.BranchProduct.find({conversion: {$in: _.pluck(conversions, '_id')}}).fetch()
      branchPrices   = Schema.BranchPrice.find({conversion: {$in: _.pluck(conversions, '_id')}}).fetch()

      Schema.Conversion.remove(conversion._id) for conversion in conversions
      Schema.BranchProduct.remove(branchProduct._id) for branchProduct in branchProducts
      Schema.BranchPrice.remove(branchPrice._id) for branchPrice in branchPrices
    return result