Module 'Wings.Validators',
  saleUpdateFields:[
    'seller'
    'buyer'
    'description'
    'depositCash'
    'selectProduct'
    'selectBranchProduct'
    'selectConversion'
    'price'
    'quality'
    'paymentDelivery'
    'paymentMethod'
  ]
#------------------------------------------------------------------------------>
  saleInsert:
    seller:
      type: String
      optional: true
      meta: [
        min: 17
        error: "sellerId không chính xác"
      ,
        max: 17
        error: "sellerId không chính xác"
      ]

    buyer:
      type: String
      optional: true
      meta: [
        min: 17
        error: "buyerId không chính xác"
      ,
        max: 17
        error: "buyerId không chính xác"
      ]

    description:
      type: String
      optional: true

#------------------------------------------------------------------------------>
  saleUpdate:
    seller:
      type: String
      optional: true
      meta: [
        min: 17
        error: "sellerId không chính xác"
      ,
        max: 17
        error: "sellerId không chính xác"
      ]

    buyer:
      type: String
      optional: true
      meta: [
        min: 17
        error: "buyerId không chính xác"
      ,
        max: 17
        error: "buyerId không chính xác"
      ]

    description:
      type: String
      optional: true

    depositCash:
      type: Match.Integer
      optional: true
      meta: [
        min: 0
        error: "depositCash không nhỏ hơn 0"
      ]