Module 'Wings.Validators',
  importCreate:
    provider:
      type: String
      optional: true
      meta: [
        min: 17
        error: "warehouseId không chính xác"
      ,
        max: 17
        error: "warehouseId không chính xác"
      ]

    description:
      type: String
      optional: true
      meta: [
        min: 0
        error: "giá không thể nhỏ hơn 0 "
      ]

    warehouse:
      type: String
      optional: true
      meta: [
        min: 17
        error: "warehouseId không chính xác"
      ,
        max: 17
        error: "warehouseId không chính xác"
      ]

  importUpdate:
    name:
      type: String
      optional: true
      meta: [
        min: 2
        error: "Tên sản phẩm không thể ngắn hơn 2 ký tự"
      ]

    price:
      type: String
      optional: true
      meta: [
        min: 0
        error: "giá không thể nhỏ hơn 0 "
      ]

    description:
      type: String
      optional: true

  importGroupCreate:
    name:
      type: String
      meta: [
        min: 2
        error: "Tên nhóm sản phẩm không thể ngắn hơn 2 ký tự"
      ]

    warehouse:
      type: String
      optional: true
      meta: [
        min: 17
        error: "warehouseId không chính xác"
      ,
        max: 17
        error: "warehouseId không chính xác"
      ]

  importGroupUpdate:
    name:
      type: String
      optional: true
      meta: [
        min: 2
        error: "Tên nhóm sản phẩm không thể ngắn hơn 2 ký tự"
      ]

    description:
      type: String
      optional: true
      meta: [
        min: 2
        error: "Tên nhóm sản phẩm không thể ngắn hơn 2 ký tự"
      ]




