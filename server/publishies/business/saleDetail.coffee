Schema.SaleDetail.before.insert (userId, saleDetail) ->
  branchPrice = Schema.BranchPrice.findOne saleDetail.branchPrice
  saleDetail.basicQuality = saleDetail.quality * branchPrice.conversionQuality

  saleDetail.returnBasicQuality = 0
  saleDetail.creator = userId if userId
  saleDetail.createdAt = new Date()

Schema.SaleDetail.before.update (userId, saleDetail, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()
  if _.contains(fieldNames, 'quality')
    branchPrice = Schema.BranchPrice.findOne saleDetail.branchPrice
    modifier.$set.basicQuality = modifier.$set.quality * branchPrice.conversionQuality


Schema.SaleDetail.after.insert (userId, saleDetail) ->
  discount = 0
  total    = saleDetail.quality * saleDetail.price
  Schema.Sale.update saleDetail.sale, $inc:{discountCash: discount, totalPrice: total, finalPrice: (total - discount)}

Schema.SaleDetail.after.update (userId, saleDetail, fieldNames, modifier, options) ->
  discount = 0
  total    = (saleDetail.quality * saleDetail.price) - (@previous.quality * @previous.price)
  Schema.Sale.update saleDetail.sale, $inc:{discountCash: discount, totalPrice: total, finalPrice: total - discount}

Schema.SaleDetail.after.remove (userId, saleDetail) ->
  discount = 0
  total    = saleDetail.quality * saleDetail.price
  Schema.Sale.update saleDetail.sale, $inc:{discountCash: discount, totalPrice: -total, finalPrice: -(total - discount)}

Schema.SaleDetail.allow
  insert: (userId, saleDetail)-> true
  update: (userId, saleDetail, fieldNames, modifier)-> true
  remove: (userId, saleDetail)-> true