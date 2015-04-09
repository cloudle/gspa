Module 'Wings.Validators',
  branchPriceUpdateFields: ['name', 'description']
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
    name:
      type: String
      optional: true
      meta: [
        min: 2
        error: "Tên sản phẩm không thể ngắn hơn 2 ký tự"
      ]


    description:
      type: String
      optional: true
