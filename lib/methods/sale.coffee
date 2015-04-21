#----Sale----->
Meteor.methods
  insertSale: (description = null, buyerId = null, sellerId = null)->
    seller = Meteor.users.findOne(sellerId) if sellerId
    buyer  = Schema.Customer.findOne(buyerId) if buyerId

    newSale = Model.Diagrams.Sale()
    newSale.seller      = seller._id if seller
    newSale.buyer       = buyer._id if buyer
    newSale.description = description if description

    insertResult = Wings.IRUS.insert(Schema.Sale, newSale, Wings.Validators.saleInsert)
    return insertResult

  updateSale: (saleId, model, fields)->
    if sale = Schema.Sale.findOne({_id: saleId, status: {$ne: "submit"}})
      result = Wings.Validators.checkExistField(fields, "saleUpdateFields")
      if result.valid then updateFields = result.data else return result

      if _.contains(updateFields, 'seller')
        return {valid: false, error: 'staff not found!'} if !Meteor.users.findOne(model.seller)

      if _.contains(updateFields, 'buyer')
        return {valid: false, error: 'customer not found!'} if !Schema.Customer.findOne(model.buyer)

      if _.contains(updateFields, 'selectProduct')
        return {valid: false, error: 'product not found!'} if !Schema.Product.findOne(model.selectProduct)

      if _.contains(updateFields, 'selectConversion')
        if branchPrice = Schema.BranchPrice.findOne({branchProduct: sale.selectBranchProduct, conversion: model.selectConversion})
          model.price = branchPrice.price; updateFields.push('price')
        else
          return {valid: false, error: 'conversion not found!'}

      if _.contains(updateFields, 'paymentMethod')
        switch model.paymentMethod
          when Wings.Enum.salePaymentMethods.cash then model.depositCash = sale.totalPrice
          when Wings.Enum.salePaymentMethods.debit then model.depositCash = 0
        updateFields.push('depositCash')

      if _.contains(updateFields, 'depositCash')
        model.finalPrice = sale.totalPrice - model.depositCash; updateFields.push('finalPrice')

      Wings.IRUS.update(Schema.Sale, sale._id, model, updateFields, Wings.Validators.saleUpdate)

  removeSale: (saleId)->
    if sale = Schema.Sale.findOne({_id: saleId, status: {$ne: "submit"}})
      result = Wings.IRUS.remove(Schema.Sale, sale._id)
      Schema.SaleDetail.find({sale: sale._id}).forEach( (saleDetail)-> Schema.SaleDetail.remove saleDetail._id ) if result.valid
      return result

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