#----SaleDetail----->
Meteor.methods
  insertSaleDetail: (saleId, branchPriceId, quality, price) ->
    sale = Schema.Sale.findOne _id: saleId, status: {$ne: "submit"}
    return {valid: false, error: 'sale not found!'} if !sale

    branchPrice = Schema.BranchPrice.findOne branchPriceId
    return {valid: false, error: 'branchPrice not found!'} if !branchPrice

    saleDetail = Model.Diagrams.SaleDetail
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
    return {valid: false, error: 'saleDetailId is not valid!'} if !saleDetail
    return {valid: false, error: 'quality and price is empty!'} if !quality and !price

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

  removeSaleDetail: (saleDetailId) ->
    saleDetail = Schema.SaleDetail.findOne({_id: saleDetailId, status: {$ne: "submit"}})
    return {valid: false, error: 'saleDetailId is not valid!'} if !saleDetail

    result = Wings.IRUS.remove(Schema.SaleDetail, saleDetail._id)
    if result.valid
      discount   = -0
      total      = -(saleDetail.quality * saleDetail.price)
      Schema.Sale.update saleDetail.sale, $inc:{discountCash: discount, totalPrice: total, finalPrice: (total - discount)}
    return result