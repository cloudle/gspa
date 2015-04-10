Model.SaleDetail.before.insert (userId, saleDetail) ->
  branchPrice = Model.BranchPrice.findOne saleDetail.branchPrice
  saleDetail.basicQuality = saleDetail.quality * branchPrice.conversionQuality

  saleDetail.returnBasicQuality = 0
  saleDetail.creator = userId if userId
  saleDetail.createdAt = new Date()

Model.SaleDetail.before.update (userId, saleDetail, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()
  if _.contains(fieldNames, 'quality')
    branchPrice = Model.BranchPrice.findOne saleDetail.branchPrice
    modifier.$set.basicQuality = modifier.$set.quality * branchPrice.conversionQuality


Model.SaleDetail.after.insert (userId, saleDetail) ->
  discount = 0
  total    = saleDetail.quality * saleDetail.price
  Model.Sale.update saleDetail.sale, $inc:{discountCash: discount, totalPrice: total, finalPrice: (total - discount)}

Model.SaleDetail.after.update (userId, saleDetail, fieldNames, modifier, options) ->
  discount = 0
  total    = (saleDetail.quality * saleDetail.price) - (@previous.quality * @previous.price)
  Model.Sale.update saleDetail.sale, $inc:{discountCash: discount, totalPrice: total, finalPrice: total - discount}

Model.SaleDetail.after.remove (userId, saleDetail) ->
  discount = 0
  total    = saleDetail.quality * saleDetail.price
  Model.Sale.update saleDetail.sale, $inc:{discountCash: discount, totalPrice: -total, finalPrice: -(total - discount)}

Model.SaleDetail.allow
  insert: (userId, saleDetail)-> true
  update: (userId, saleDetail, fieldNames, modifier)-> true
  remove: (userId, saleDetail)-> true