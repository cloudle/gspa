Wings.Validators.providerCreate =
  name:
    type: String
    meta: [
      min: 2
      error: "Tên nhà cung cấp không thể ngắn hơn 2 ký tự"
    ]

  phone:
    type: String
    optional: true
    meta: [
      min: 9
      error: "Số điện thoại không thể ngắn hơn 9 ký tự"
    ]

Wings.Validators.providerUpdate =
  name:
    type: String
    optional: true
    meta: [
      min: 2
      error: "Tên nhà cung cấp không thể ngắn hơn 2 ký tự"
    ]

  phone:
    type: String
    optional: true
    meta: [
      min: 9
      error: "Số điện thoại không thể ngắn hơn 9 ký tự"
    ]

  description:
    type: String
    optional: true

  address:
    type: String
    optional: true