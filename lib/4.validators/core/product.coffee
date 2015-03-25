Wings.Validators.productCreate =
  name:
    type: String
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

Wings.Validators.productUpdate =
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

Wings.Validators.productGroupCreate =
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

Wings.Validators.productGroupUpdate =
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




