Module 'Wings.Validators',
  conversionUpdateFields: ['name', 'description']
#------------------------------------------------------------------------------
  conversionInsert:
    product:
      type: String
      meta: [
        min: 17
        error: "productId không chính xác"
      ,
        max: 17
        error: "productId không chính xác"
      ]

    unit:
      type: String
      meta: [
        min: 17
        error: "unitId không chính xác"
      ,
        max: 17
        error: "unitId không chính xác"
      ]

    conversion:
      type: Match.Integer
      meta: [
        min: 1
        error: "Quy đổi không thể nhỏ hơn 1"
      ]


#------------------------------------------------------------------------------
  conversionUpdate:
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
