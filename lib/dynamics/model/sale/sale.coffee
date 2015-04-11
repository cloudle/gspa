class Model.Sale
  constructor: (doc) -> @[key] = value for key, value of doc

  @insert: (description, buyer = null, seller = null)->
    newSale = {seller: seller ? Meteor.userId()}
    newSale.buyer       = buyer if buyer
    newSale.description = description if description

    Wings.IRUS.insert(Schema.Sale, newSale, Wings.Validators.saleInsert)

  insert: ->
    return {valid: false, error: 'This record is created'} if @_id
    newSale = {seller: @seller}
    newSale.buyer       = @buyer if @buyer
    newSale.description = @description if @description

    insertResult = Wings.IRUS.insert(Schema.Sale, newSale, Wings.Validators.saleInsert)
    @_id = insertResult.result if insertResult.valid
    return insertResult

  update: (fields)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    result = Wings.Validators.checkExistField(fields, "saleUpdateFields")
    if result.valid then updateFields = result.data else return result

    Wings.IRUS.update(Schema.Sale, @_id, @, updateFields, Wings.Validators.saleUpdate)

  remove: ->
    Wings.IRUS.remove(Schema.Sale, @_id)

  insertDetail: (branchPriceId, quality, price)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    newDetail = {sale: @_id, branchPrice: branchPriceId, quality: Wings.Convert.toNumber(quality), price: Wings.Convert.toNumber(price)}
    console.log newDetail
    Wings.IRUS.insert(Schema.SaleDetail, newDetail, Wings.Validators.saleDetailInsert)

  submitSale: ->
    return {valid: false, error: 'This _id is required!'} if !sale = Schema.Sale.findOne @_id
    return {valid: false, error: 'This Import is Submit!'} if sale.status is "submit"

    saleDetails    = Schema.SaleDetail.find({sale: sale._id}).fetch()
    branchProducts = Schema.BranchProduct.find({_id: {$in: _.uniq(_.pluck(saleDetails, 'branchProduct'))} }).fetch()

    if branchProducts.length > 0
      result = checkProductInStockQuality(saleDetails, branchProducts)
      return result if !result.valid

    for saleDetail in saleDetails
      importDetails = []
      Schema.BranchPrice.find({branchProduct: saleDetail.branchProduct}).forEach(
        (branchPrice) ->
          details = Schema.ImportDetail.find({branchPrice: branchPrice._id, availableQuality: {$gt: 0}}
            {sort: {'version.createdAt': 1}}).fetch()

          importDetails.push detail for detail in details
      )
      if subtractQualityOnSales(importDetails, saleDetail)
        Schema.Sale.update sale._id, $set:{status: "submit"}


checkProductInStockQuality = (saleDetails, branchProducts)->
  details = _.chain(saleDetails)
  .groupBy("branchProduct")
  .map (group, key) ->
    return {
    product      : group[0].product
    branchProduct: group[0].branchProduct
    basicQuality : _.reduce(group, ((res, current) -> res + current.basicQuality), 0)
    }
  .value()

  result = {valid: true, errorItem: []}
  if branchProducts.length > 0 and details.length > 0
    for currentDetail in details
      currentProduct = _.findWhere(branchProducts, {_id: currentDetail.branchProduct})
      if currentProduct?.availableQuality < currentDetail.basicQuality
        result.errorItem.push detail for detail in _.where(saleDetails, {branchProduct: currentDetail.branchProduct})
        (result.valid = false; result.message = "sản phẩm không đủ số lượng") if result.valid
  else
    result = {valid: false, message: "Danh sách sản phẩm trống." }

  return result

subtractQualityOnSales = (importDetails, saleDetail) ->
  transactionQuality = 0
  for importDetail in importDetails
    requiredQuality = saleDetail.basicQuality - transactionQuality
    takenQuality = if importDetail.availableQuality > requiredQuality then requiredQuality else importDetail.availableQuality

    console.log takenQuality
    console.log importDetail

    updateProduct = {availableQuality: -takenQuality, inStockQuality: -takenQuality, saleQuality: takenQuality}
    Schema.Product.update importDetail.product, $inc: updateProduct
    Schema.BranchProduct.update importDetail.branchProduct, $inc: updateProduct
    Schema.ImportDetail.update importDetail._id, $inc: updateProduct, $push:{saleDetail: {id:saleDetail._id, quality: takenQuality}}
    Schema.SaleDetail.update saleDetail._id, $set:{status: "submit"}, $push:{importDetail: {id:importDetail._id, quality: takenQuality}}

    transactionQuality += takenQuality
    if transactionQuality == saleDetail.basicQuality then break

  return transactionQuality == saleDetail.basicQuality