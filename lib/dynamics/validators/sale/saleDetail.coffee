Module 'Wings.Validators',
  saleDetailUpdateFields: ['quality', 'price']
#------------------------------------------------------------------------------>
  saleDetailInsert:
    sale:
      type: String
      optional: true
      meta: [
        min: 17
        error: "sellerId không chính xác"
      ,
        max: 17
        error: "sellerId không chính xác"
      ]

    branchPrice:
      type: String
      optional: true
      meta: [
        min: 17
        error: "buyerId không chính xác"
      ,
        max: 17
        error: "buyerId không chính xác"
      ]

    quality:
      type: Match.Integer
      meta: [
        min: 0
        error: "số lượng không lớn hơn 0"
      ]

    price:
      type: Match.Integer
      meta: [
        min: 0
        error: "giá phải lớn hơn 0"
      ]

#------------------------------------------------------------------------------>
  saleDetailUpdate:
    quality:
      type: Match.Integer
      optional: true
      meta: [
        min: 0
        error: "số lượng không lớn hơn 0"
      ]

    price:
      type: Match.Integer
      optional: true
      meta: [
        min: 0
        error: "giá phải lớn hơn 0"
      ]