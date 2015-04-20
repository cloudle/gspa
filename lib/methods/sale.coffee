Meteor.methods
  updateSaleDepositCash: (saleId, deposit = 0) ->
    if sale = Schema.Sale.findOne({ _id: saleId, status: {$ne: "submit"} })
      sale.depositCash  = Convert.toNumber(deposit)
      sale.finalPrice   = sale.totalPrice - sale.depositCash
      Wings.IRUS.update(Schema.Sale, sale._id, sale, ['depositCash', 'finalPrice'], Wings.Validators.saleUpdate)

  submitSale: (saleId)->
    if sale = Schema.Sale.findOne({ _id: saleId, status: {$ne: "submit"} })
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
          Schema.Sale.update sale._id, $set: {status: "submit", submitAt: new Date()}

          if !Schema.Sale.findOne({status: {$ne: "submit"} })
            Model.Sale.insert(null, sale.buyer, sale.seller)

  addSaleDetail: (saleId, branchPriceId, quality, price) ->
    sale        = Schema.Sale.findOne _id: saleId, status: {$ne: "submit"}
    branchPrice = Schema.BranchPrice.findOne branchPriceId

    if sale and branchPrice
      saleDetail = {creator: @userId, returnBasicQuality : 0}
      saleDetail.sale         = sale._id
      saleDetail.branchPrice  = branchPrice._id
      saleDetail.quality      = Convert.toNumber(quality)
      saleDetail.price        = Convert.toNumber(price)
      saleDetail.basicQuality = saleDetail.quality * branchPrice.conversionQuality

      insertResult = Wings.IRUS.insert(Schema.SaleDetail, saleDetail, Wings.Validators.saleDetailInsert)
      if insertResult.valid
        discount = 0
        total    = saleDetail.quality * saleDetail.price
        Schema.Sale.update sale._id, $inc:{discountCash: discount, totalPrice: total, finalPrice: (total - discount)}

      return insertResult

  updateSaleDetail: (saleDetailId, quality = null, price = null) ->
    saleDetail = Schema.SaleDetail.findOne({_id: saleDetailId, status: {$ne: "submit"}})
    if saleDetail and (quality or price)
      conversion = saleDetail.basicQuality/saleDetail.quality
      model = {}; updateFields = []

      if price
        model.price = Convert.toNumber(price)
        updateFields.push 'price'
      else
        model.price = saleDetail.price

      if quality
        model.quality      = Convert.toNumber(quality)
        model.basicQuality = model.quality * conversion
        updateFields.push 'quality'
        updateFields.push 'basicQuality'
      else
        model.quality = saleDetail.quality

      result = Wings.IRUS.update(Schema.SaleDetail, saleDetail._id, model, updateFields, Wings.Validators.saleDetailUpdate)
      if result.valid
        discount   = 0
        total      = (model.quality * model.price) - (saleDetail.quality * saleDetail.price)
        Schema.Sale.update saleDetail.sale, $inc: {discountCash: discount, totalPrice: total, finalPrice: (total - discount)}

      return result

  deleteSaleDetail: (saleDetailId) ->
    if saleDetail = Schema.SaleDetail.findOne({_id: saleDetailId, status: {$ne: "submit"}})
      result = Wings.IRUS.remove(Schema.SaleDetail, saleDetail._id)
      if result.valid
        discount   = -0
        total      = -(saleDetail.quality * saleDetail.price)
        Schema.Sale.update saleDetail.sale, $inc:{discountCash: discount, totalPrice: total, finalPrice: (total - discount)}
      return result

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