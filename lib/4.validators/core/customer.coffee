Wings.Validators.customerCreate =
  name:
    type: String
    meta: [
      min: 2
      error: "Tên khách hàng không thể ngắn hơn 2 ký tự"
    ]

  phone:
    type: String
    optional: true
    meta: [
      min: 9
      error: "Số điện thoại không thể ngắn hơn 9 ký tự"
    ]

Wings.Validators.customerUpdate =
  name:
    type: String
    optional: true
    meta: [
      min: 2
      error: "Tên khách hàng không thể ngắn hơn 2 ký tự"
    ]

  phone:
    type: String
    optional: true
    meta: [
      min: 9
      error: "Số điện thoại không thể ngắn hơn 9 ký tự"
    ]

  gender:
    type: Boolean
    optional: true

  dateOfBirth:
    type: Date
    optional: true

  description:
    type: String
    optional: true

  address:
    type: String
    optional: true

  email:
    type: String
    optional: true

Wings.Validators.customerGroupCreate =
  name:
    type: String
    meta: [
      min: 2
      error: "Tên nhóm khách hàng không thể ngắn hơn 2 ký tự"
    ]

Wings.Validators.customerGroupUpdate =
  name:
    type: String
    optional: true
    meta: [
      min: 2
      error: "Tên nhóm khách hàng không thể ngắn hơn 2 ký tự"
    ]

  description:
    type: String
    optional: true
    meta: [
      min: 2
      error: "Tên nhóm khách hàng không thể ngắn hơn 2 ký tự"
    ]



