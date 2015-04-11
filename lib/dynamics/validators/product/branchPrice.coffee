Module 'Wings.Validators',
  branchPriceUpdateFields: ['price', 'importPrice']
#------------------------------------------------------------------------------
  branchPriceInsert:
    branchProduct:
      type: String
      meta: [
        min: 17
        error: "branchId không chính xác"
      ,
        max: 17
        error: "branchId không chính xác"
      ]

    conversion:
      type: String
      optional: true
      meta: [
        min: 17
        error: "branchId không chính xác"
      ,
        max: 17
        error: "branchId không chính xác"
      ]

#------------------------------------------------------------------------------
  branchPriceUpdate:
    price:
      type: Match.Integer
      optional: true
      meta: [
        min: 0
        error: "branchId không chính xác"
      ]

    importPrice:
      type: Match.Integer
      optional: true
      meta: [
        min: 0
        error: "branchId không chính xác"
      ]