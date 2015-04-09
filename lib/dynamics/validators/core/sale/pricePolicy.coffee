Module 'Wings.Validators',
  pricePolicyCreate:
    name:
      type: String
      meta: [
        min: 2
        error: "Tên bản giá sản phẩm không thể ngắn hơn 2 ký tự"
      ]

    description:
      type: String
      optional: true

  pricePolicyUpdate:
    name:
      type: String
      optional: true
      meta: [
        min: 2
        error: "Tên bản giá sản phẩm không thể ngắn hơn 2 ký tự"
      ]

    description:
      type: String
      optional: true

  pricePolicyUpdateProductPrice:
    product:
      type: String
  #    meta: [
  #      min: 17
  #      error: "ID của sản phẩm không chính xác"
  #    ,
  #      max: 17
  #      error: "ID của sản phẩm không chính xác"
  #    ]

    price:
      type: Match.Integer
      meta: [
        min: 0
        error: "Giá của sản phẩm phải lớn hơn 0."
      ]