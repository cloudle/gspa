Module 'Wings.Validators',
  productUpdateFields: ['name', 'description']
#------------------------------------------------------------------------------
  productInsert:
    name:
      type: String
      meta: [
        min: 2
        error: "Tên sản phẩm không thể ngắn hơn 2 ký tự"
      ]

    description:
      type: String
      optional: true

#------------------------------------------------------------------------------
  productUpdate:
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

#--------------------------------------------------------------------------------
  productBasicUnit:
    basicUnit:
      type: String
      meta: [
        min: 17
        error: "unitId không chính xác"
      ,
        max: 17
        error: "unitId không chính xác"
      ]
