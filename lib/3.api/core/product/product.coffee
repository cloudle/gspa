Wings.Product = {}

Wings.Product.insert = (name, price = null, description = null, warehouse = null)->
  newProduct = {name: name}
  newProduct.price       = price if price
  newProduct.description = description if description
  newProduct.warehouse   = warehouse if warehouse

  insertResult = Wings.CRUD.insert(Model.Product, newProduct, Wings.Validators.productCreate)
  console.log insertResult.error unless insertResult.valid
  return insertResult


Wings.Product.update = (option, productId)->
  fields = ['name', 'price', 'description']
  updateResult = Wings.CRUD.update(Model.Product, productId, option, fields, Wings.Validators.productUpdate)
  console.log updateResult.error unless updateResult.valid
  return updateResult

Wings.Product.remove = (productId)->
  removeResult = Wings.CRUD.remove(Model.Product, productId)
  console.log removeResult.error unless removeResult.valid
  return removeResult