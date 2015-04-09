Module 'Wings.Validators',
  productGroupUpdateFields: ['name', 'description']
#------------------------------------------------------------------------------
  productGroupInsert:
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
  productGroupUpdate:
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