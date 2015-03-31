Wings.Sale.PricePolicy = {}

Wings.Sale.PricePolicy.insert = (name, description = undefined)->
  newPricePolicy = {name: name}
  newPricePolicy.description = description if description

  insertResult = Wings.IRUS.insert(Model.PricePolicy, newPricePolicy, Wings.Validators.pricePolicyCreate)
  console.log insertResult.error unless insertResult.valid
  return insertResult

Wings.Sale.PricePolicy.update = (option, pricePolicyId)->
  fields = ['name', 'description']
  updateResult = Wings.IRUS.update(Model.PricePolicy, pricePolicyId, option, fields, Wings.Validators.pricePolicyUpdate)
  console.log updateResult.error unless updateResult.valid
  return updateResult

Wings.Sale.PricePolicy.remove = (pricePolicyId)->
  removeResult = Wings.IRUS.remove(Model.PricePolicy, pricePolicyId)
  console.log removeResult.error unless removeResult.valid
  return removeResult

Wings.Sale.PricePolicy.addProduct = (productLists = undefined, pricePolicyId = undefined)->
  if _.isArray(productLists) then arrayProduct = productLists else arrayProduct = [productLists]

  isValidModel = Wings.IRUS.validate(productLists, Wings.Validators.pricePolicyUpdateProductPrice, true)
  return isValidModel unless isValidModel.valid

  for item in arrayProduct
    if (Model.PricePolicy.update pricePolicyId, $pull: {productList:{product: item.product}})
      if (Model.PricePolicy.update pricePolicyId, $addToSet: {productList: item})
        Model.Product.update item.product, $addToSet: {pricePolicy: pricePolicyId}
    else
      return {valid: false, error: 'pricePolicyId is not valid'}

  return {valid: true}

Wings.Sale.PricePolicy.removeProduct = (productLists = undefined, pricePolicyId = undefined)->
  if _.isArray(productLists) then arrayProduct = productLists else arrayProduct = [productLists]

  if Match.test(arrayProduct, [String])
    return {valid: false, error: "productLists is required."} if arrayProduct.length < 1
  else
    return {valid: false, error: "productLists is required."}

  for product in arrayProduct
    if (Model.PricePolicy.update pricePolicyId, $pull: {productList: {product: product}})
      Model.Product.update item.product, $addToSet: {pricePolicy: pricePolicyId}
    else
      return {valid: false, error: 'pricePolicyId is not valid'}

  return {valid: true}
