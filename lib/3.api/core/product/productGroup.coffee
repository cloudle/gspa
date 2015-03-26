Wings.Product.Group = {}

Wings.Product.Group.insert = (name, warehouse = null)->
  newGroup = {name: name}
  newGroup.warehouse = warehouse if warehouse

  insertResult = Wings.IRUS.insert(Model.ProductGroup, newGroup, Wings.Validators.productGroupCreate)
  console.log insertResult.error unless insertResult.valid
  return insertResult

Wings.Product.Group.update = (option, groupId = undefined)->
  fields = ['name', 'description']
  updateResult = Wings.IRUS.update(Model.ProductGroup, groupId, option, fields, Wings.Validators.productGroupUpdate)
  console.log updateResult.error unless updateResult.valid
  return updateResult

Wings.Product.Group.remove = (groupId)->
  removeResult = Wings.IRUS.remove(Model.ProductGroup, groupId)
  return removeResult

Wings.Product.Group.addProduct = (productLists, groupId = undefined)->
  if _.isArray(productLists) then arrayProduct = productLists else arrayProduct = [productLists]

  if Match.test(arrayProduct, [String])
    return {valid: false, error: "productLists is required."} if arrayProduct.length < 1
  else
    return {valid: false, error: "productLists is required."}

  if (Model.ProductGroup.update groupId, $addToSet: {productList: {$each: arrayProduct}})
    (Model.Product.update productId, $addToSet: {productGroup: groupId}) for productId in arrayProduct
    return {valid: true}
  else
    return {valid: false, error: 'productGroupId is not valid.'}


Wings.Product.Group.removeProduct = (productLists = undefined, groupId = undefined)->
  if _.isArray(productLists) then arrayProduct = productLists else arrayProduct = [productLists]

  if Match.test(arrayProduct, [String])
    return {valid: false, error: "productLists is required."} if arrayProduct.length < 1
  else
    return {valid: false, error: "productLists is required."}

  for productId in arrayProduct
    if (Model.ProductGroup.update groupId, $pull: {productList: productId})
      Model.Product.update productId, $pull: {productGroup: groupId}
    else
      return {valid: false, error: "productGroupId is not valid."}
  return {valid: true}