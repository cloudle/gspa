Wings.Validators.leafCreate =
  name:
    type: String
    meta: [
      min: 2
      error: "Property không thể ngắn hơn 2 ký tự"
    ]

  parent:
    type: String

  leafType:
    type: Match.Integer
