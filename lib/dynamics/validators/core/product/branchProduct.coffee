Module 'Wings.Validators',
  branchProductUpdateFields: ['name', 'description']
#------------------------------------------------------------------------------
  branchProductInsert:
    branch:
      type: String
      meta: [
        min: 17
        error: "branchId không chính xác"
      ,
        max: 17
        error: "branchId không chính xác"
      ]

    product:
      type: String
      meta: [
        min: 17
        error: "productId không chính xác"
      ,
        max: 17
        error: "productId không chính xác"
      ]

#------------------------------------------------------------------------------
  branchProductUpdate:
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
