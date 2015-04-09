Module 'Wings.Validators',
  importDetailUpdateFields: ['quality', 'price', 'expire']
#-------------------------------------------------------------------------
  importDetailInsert:
    import:
      type: String
      meta: [
        min: 17
        error: "importId không chính xác"
      ,
        max: 17
        error: "importId không chính xác"
      ]

    branchPrice:
      type: String
      optional: true
      meta: [
        min: 17
        error: "branchPriceId không chính xác"
      ,
        max: 17
        error: "branchPriceId không chính xác"
      ]

    quality:
      type: Match.Integer
      optional: true
      meta: [
        min: 0
        error: "Số lượng không nhỏ hơn 0"
      ]

    price:
      type: Match.Integer
      optional: true
      meta: [
        min: 0
        error: "Giá nhập không nhỏ hơn 0"
      ]

    expire:
      type: Date
      optional: true

#-------------------------------------------------------------------------
  importDetailUpdate:
    quality:
      type: Match.Integer
      optional: true
      meta: [
        min: 1
        error: "Số lượng phải lớn hơn 0"
      ]

    price:
      type: Match.Integer
      optional: true
      meta: [
        min: 0
        error: "Giá nhập không nhỏ hơn 0"
      ]

    expire:
      type: Date
      optional: true
