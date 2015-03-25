Wings.Validators.accountCreate =
  username:
    type: String
    optional: true
    meta: [
      min: 2
      error: "Property không thể ngắn hơn 2 ký tự"
    ]

  email:
    type: String
    optional: true
    meta: [
      min: 2
      error: "Property không thể ngắn hơn 2 ký tự"
    ]

  password:
    type: String
    meta: [
      min: 2
      error: "Property không thể ngắn hơn 2 ký tự"
    ]
