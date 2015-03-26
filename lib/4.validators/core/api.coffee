Wings.Validators.leafCreate =
  name:
    type: String
    meta: [
      min: 2
      error: "Tên không thể ngắn hơn 2 ký tự"
    ]

  parent:
    type: String

  leafType:
    type: Match.Integer
